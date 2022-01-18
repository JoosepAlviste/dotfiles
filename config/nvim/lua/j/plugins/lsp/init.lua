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
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  update_in_insert = false,
})

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
    vim.lsp.util.apply_text_edits(result, ctx.bufnr)
    vim.fn.winrestview(view)
    if ctx.bufnr == vim.api.nvim_get_current_buf() or not ctx.bufnr then
      vim.api.nvim_command 'noautocmd :update'
    end
  end
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

local icons = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Field = '',
  TypeParameter = '',
}

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
  kinds[i] = icons[kind] or kind
end

-- Construct some utilities that are needed for setting up the LSP servers

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
  buf_map(bufnr, 'n', '<leader>ca', function()
    builtin.lsp_code_actions(require('telescope.themes').get_cursor())
  end, opts)
  buf_map(bufnr, 'n', '<space>rn', vim.lsp.buf.rename.float, opts)

  -- Navigate diagnostics
  buf_map(bufnr, 'n', '[g', function()
    vim.diagnostic.goto_prev { float = { border = 'rounded' } }
  end, opts)
  buf_map(bufnr, 'n', ']g', function()
    vim.diagnostic.goto_next { float = { border = 'rounded' } }
  end, opts)
  -- Show diagnostics popup with <leader>d
  buf_map(bufnr, 'n', '<leader>d', function()
    vim.diagnostic.open_float(0, { scope = 'line', border = 'rounded' })
  end, opts)

  -- Mouse mappings for easily navigating code
  if client.resolved_capabilities.goto_definition then
    buf_map(bufnr, 'n', '<RightMouse>', '<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>', { silent = true })
  end

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[augroup LspFormatting]]
    vim.cmd [[autocmd! * <buffer>]]
    vim.cmd [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
    vim.cmd [[augroup END]]
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require('cmp_nvim_lsp').update_capabilities(M.capabilities)

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
    return item.uri and not string.match(item.uri, 'node_modules')
  end, results)

  if #without_node_modules > 0 then
    return without_node_modules
  end

  return results
end

-- This function is mostly copied from Telescope, I only added the
-- `node_modules` filtering.
local function list_or_jump(action, title, opts)
  opts = opts or {}

  local params = vim.lsp.util.make_position_params()
  local result, err = vim.lsp.buf_request_sync(0, action, params, opts.timeout or 10000)
  if err then
    vim.api.nvim_err_writeln('Error when executing ' .. action .. ' : ' .. err)
    return
  end
  local flattened_results = {}
  for _, server_results in pairs(result) do
    if server_results.result then
      vim.list_extend(flattened_results, server_results.result)
    end
  end

  -- This is the only added step to the Telescope function
  flattened_results = filter_out_libraries_from_lsp_items(flattened_results)

  if #flattened_results == 0 then
    return
  elseif #flattened_results == 1 then
    vim.lsp.util.jump_to_location(flattened_results[1])
  else
    local locations = vim.lsp.util.locations_to_items(flattened_results)
    pickers.new(opts, {
      prompt_title = title,
      finder = finders.new_table {
        results = locations,
        entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
      },
      previewer = conf.qflist_previewer(opts),
      sorter = conf.generic_sorter(opts),
    }):find()
  end
end

function M.definitions(opts)
  return list_or_jump('textDocument/definition', 'LSP Definitions', opts)
end

vim.lsp.handlers['textDocument/rename'] = function(err, result)
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
  vim.lsp.util.apply_workspace_edit(result)
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
      "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('" .. curr_name .. ',' .. win .. "')<CR>",
      map_opts
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      '<CR>',
      "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('" .. curr_name .. ',' .. win .. "')<CR>",
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
