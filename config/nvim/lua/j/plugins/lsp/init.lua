local finders = require 'telescope.finders'
local pickers = require 'telescope.pickers'
local make_entry = require 'telescope.make_entry'
local conf = require('telescope.config').values
local builtin = require 'telescope.builtin'

local buf_map = require('j.utils').buf_map

-- Highlight line numbers for diagnostics
vim.fn.sign_define('DiagnosticSignError', { numhl = 'LspDiagnosticsLineNrError', text = '' })
vim.fn.sign_define('DiagnosticSignWarn', { numhl = 'LspDiagnosticsLineNrWarning', text = '' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '' })
vim.fn.sign_define('DiagnosticSignHint', { text = '' })

-- Configure diagnostics displaying
vim.diagnostic.config {
  virtual_text = false,
  float = {
    border = 'rounded',
    format = function(diagnostic)
      if diagnostic.source == '' then
        return diagnostic.message
      end

      if diagnostic.source == 'eslint' then
        return string.format(
          '%s [%s]',
          diagnostic.message,
          -- shows the name of the rule
          diagnostic.user_data.lsp.code
        )
      end

      return string.format('%s [%s]', diagnostic.message, diagnostic.source)
    end,
    suffix = function()
      return ''
    end,
    severity_sort = true,
    close_events = { 'CursorMoved', 'InsertEnter' },
  },
}

-- Use FZF to find references
-- vim.lsp.handlers['textDocument/references'] = require('j.plugins.fzf.functions').lsp_references_handler

-- Handle formatting in a smarter way
-- If the buffer has been edited before formatting has completed, do not try to
-- apply the changes
vim.lsp.handlers['textDocument/formatting'] = function(err, result, ctx, _)
  if err ~= nil or result == nil then
    return
  end

  -- If the buffer hasn't been modified before the formatting has finished,
  -- update the buffer
  if not vim.api.nvim_buf_get_option(ctx.bufnr, 'modified') then
    local view = vim.fn.winsaveview()
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    vim.lsp.util.apply_text_edits(result, ctx.bufnr, client.offset_encoding)
    vim.fn.winrestview(view)
    if ctx.bufnr == vim.api.nvim_get_current_buf() or not ctx.bufnr then
      vim.api.nvim_command 'noautocmd :update'
    end
  end
end

-- Construct some utilities that are needed for setting up the LSP servers

local formatting_augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local M = {}

function M.on_attach(client, bufnr)
  -- Set up keymaps
  local opts = { noremap = true, silent = true }
  buf_map(bufnr, 'n', '<c-]>', M.definitions, opts)
  buf_map(bufnr, 'n', 'gd', vim.lsp.buf.declaration, opts)
  buf_map(bufnr, 'n', 'gi', vim.lsp.buf.implementation, opts)
  buf_map(bufnr, 'n', 'gD', vim.lsp.buf.type_definition, opts)
  buf_map(bufnr, 'n', 'gr', builtin.lsp_references, opts)

  buf_map(bufnr, 'n', 'K', vim.lsp.buf.hover, opts)
  buf_map(bufnr, 'n', '<leader>ca', vim.lsp.buf.code_action, opts)
  buf_map(bufnr, 'n', '<space>rn', vim.lsp.buf.rename.float, opts)

  -- Navigate diagnostics
  buf_map(bufnr, 'n', '[g', vim.diagnostic.goto_prev, opts)
  buf_map(bufnr, 'n', ']g', vim.diagnostic.goto_next, opts)
  -- Diagnostics popup
  buf_map(bufnr, 'n', '<leader>d', vim.diagnostic.open_float, opts)

  -- Mouse mappings for easily navigating code
  if client.server_capabilities.definitionProvider then
    buf_map(bufnr, 'n', '<RightMouse>', '<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>', { silent = true })
  end

  -- Highlight symbol references on hover
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = false })
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = 'LspDocumentHighlight',
    }
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'LspDocumentHighlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = 'LspDocumentHighlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- Autoformatting
  local formatting_disabled_ls = { 'volar', 'intelephense', 'tsserver' }
  if client.supports_method 'textDocument/formatting' and not vim.tbl_contains(formatting_disabled_ls, client.name) then
    vim.api.nvim_clear_autocmds { group = formatting_augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = formatting_augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format {
          filter = function(buf_client)
            return not vim.tbl_contains(formatting_disabled_ls, buf_client.name)
          end,
        }
      end,
    })
  end

  -- Disable semantic token highlighting, it is worse in some cases than
  -- treesitter (e.g., SCREAMING_SNAKE_CASE constants or builtin variables)
  -- I think that "modifiers" is what we need in order to be able to have a bit
  -- nicer highlighting with LSP?
  client.server_capabilities.semanticTokensProvider = nil
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- If the LSP response includes any `node_modules`, then try to remove them and
-- see if there are any options left. We probably want to navigate to the code
-- in OUR codebase, not inside `node_modules`.
--
-- This can happen if a type is used to explicitly type a variable:
-- ```ts
-- const MyComponent: React.FC<Props> = () => <div />
-- ````
--
-- Running "Go to definition" on `MyComponent` would give the `React.FC`
-- definition in `node_modules/react` as the first result, but we don't want
-- that.
local function filter_out_libraries_from_lsp_items(results)
  local without_node_modules = vim.tbl_filter(function(item)
    return item.targetUri and not string.match(item.targetUri, 'node_modules')
  end, results)

  if #without_node_modules > 0 then
    return without_node_modules
  end

  return results
end

local function filter_out_same_location_from_lsp_items(results)
  return vim.tbl_filter(function(item)
    local from = item.originSelectionRange
    local to = item.targetSelectionRange

    return not (
      from
      and from.start.character == to.start.character
      and from.start.line == to.start.line
      and from['end'].character == to['end'].character
      and from['end'].line == to['end'].line
    )
  end, results)
end

-- This function is mostly copied from Telescope, I only added the
-- `node_modules` filtering.
local function list_or_jump(action, title, opts)
  opts = opts or {}

  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, action, params, function(err, result, ctx, _config)
    if err then
      vim.api.nvim_err_writeln('Error when executing ' .. action .. ' : ' .. err.message)
      return
    end
    local flattened_results = {}
    if result then
      -- textDocument/definition can return Location or Location[]
      if not vim.tbl_islist(result) then
        flattened_results = { result }
      end

      vim.list_extend(flattened_results, result)
    end

    -- This is the only added step to the Telescope function
    flattened_results = filter_out_same_location_from_lsp_items(filter_out_libraries_from_lsp_items(flattened_results))

    local offset_encoding = vim.lsp.get_client_by_id(ctx.client_id).offset_encoding

    if #flattened_results == 0 then
      return
    elseif #flattened_results == 1 and opts.jump_type ~= 'never' then
      if opts.jump_type == 'tab' then
        vim.cmd.tabedit()
      elseif opts.jump_type == 'split' then
        vim.cmd.new()
      elseif opts.jump_type == 'vsplit' then
        vim.cmd.vnew()
      end
      vim.lsp.util.jump_to_location(flattened_results[1], offset_encoding)
    else
      local locations = vim.lsp.util.locations_to_items(flattened_results, offset_encoding)
      pickers
        .new(opts, {
          prompt_title = title,
          finder = finders.new_table {
            results = locations,
            entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
          },
          previewer = conf.qflist_previewer(opts),
          sorter = conf.generic_sorter(opts),
        })
        :find()
    end
  end)
end

function M.definitions(opts)
  return list_or_jump('textDocument/definition', 'LSP Definitions', opts)
end

vim.lsp.handlers['textDocument/rename'] = function(err, result, ctx)
  if err then
    vim.notify(("Error running lsp query 'rename': " .. err), vim.log.levels.ERROR)
  end

  if result and result.changes then
    local new_name = ''
    local old_name = vim.fn.expand '<cword>'

    local msg = ''
    for f, c in pairs(result.changes) do
      new_name = c[1].newText
      msg = msg .. ('%d changes -> %s'):format(#c, f:gsub('file://', ''):gsub(vim.pesc(vim.loop.cwd()), '.')) .. '\n'
    end
    -- Remove the last new line
    msg = msg:sub(1, #msg - 1)

    vim.notify(msg, vim.log.levels.INFO, { title = ('Rename: %s -> %s'):format(old_name, new_name) })
  end

  local client = vim.lsp.get_client_by_id(ctx.client_id)
  vim.lsp.util.apply_workspace_edit(result, client.offset_encoding)
end

vim.lsp.buf.rename = {
  float = function()
    local curr_name = vim.fn.expand '<cword>'
    local tshl = require('nvim-treesitter-playground.hl-info').get_treesitter_hl()
    if tshl and #tshl > 0 then
      local ind = tshl[#tshl]:match '^.*()%*%*.*%*%*'
      tshl = tshl[#tshl]:sub(ind + 2, -3)
    end

    local win = require('plenary.popup').create(curr_name, {
      title = 'New Name',
      style = 'minimal',
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      relative = 'cursor',
      borderhighlight = 'FloatBorder',
      titlehighlight = 'Title',
      highlight = tshl,
      focusable = true,
      width = 25,
      height = 1,
      line = 'cursor+2',
      col = 'cursor-1',
    })

    local map_opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(0, 'i', '<Esc>', '<cmd>stopinsert | q!<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<Esc>', '<cmd>stopinsert | q!<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(
      0,
      'i',
      '<CR>',
      "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('" .. curr_name .. "'," .. win .. ')<CR>',
      map_opts
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      '<CR>',
      "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('" .. curr_name .. "'," .. win .. ')<CR>',
      map_opts
    )
  end,
  apply = function(curr, win)
    local newName = vim.trim(vim.api.nvim_get_current_line())
    vim.api.nvim_win_close(win, true)
    if #newName > 0 and newName ~= curr then
      local params = vim.lsp.util.make_position_params()
      params.newName = newName
      vim.lsp.buf_request(0, 'textDocument/rename', params)
    end
  end,
}

return M
