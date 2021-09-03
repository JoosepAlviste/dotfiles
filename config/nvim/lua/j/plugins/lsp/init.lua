local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local make_entry = require('telescope.make_entry')
local conf = require('telescope.config').values

-- Highlight line numbers for diagnostics
vim.fn.sign_define('LspDiagnosticsSignError', {numhl = 'LspDiagnosticsLineNrError', text = ''})
vim.fn.sign_define('LspDiagnosticsSignWarning', {numhl = 'LspDiagnosticsLineNrWarning', text = ''})
vim.fn.sign_define('LspDiagnosticsSignInformation', {text = ''})
vim.fn.sign_define('LspDiagnosticsSignHint', {text = ''})

-- Configure diagnostics displaying
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

-- Use FZF to find references
-- vim.lsp.handlers['textDocument/references'] = require('j.plugins.fzf.functions').lsp_references_handler

-- Handle formatting in a smarter way
-- If the buffer has been edited before formatting has completed, do not try to 
-- apply the changes
vim.lsp.handlers['textDocument/formatting'] = function(err, _, result, _, bufnr)
  if err ~= nil or result == nil then
    return
  end

  -- If the buffer hasn't been modified before the formatting has finished, 
  -- update the buffer
  if not vim.api.nvim_buf_get_option(bufnr, 'modified') then
    local view = vim.fn.winsaveview()
    vim.lsp.util.apply_text_edits(result, bufnr)
    vim.fn.winrestview(view)
    if bufnr == vim.api.nvim_get_current_buf() or not bufnr then
      vim.api.nvim_command('noautocmd :update')
    end
  end
end

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(
    vim.lsp.handlers.hover,
    {
      border = "single"
    }
  )

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
  TypeParameter = ''
}

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
  kinds[i] = icons[kind] or kind
end

-- Construct some utilities that are needed for setting up the LSP servers

local M = {}

function M.on_attach(client, bufnr)
  local function buf_map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Set up keymaps
  local opts = {noremap = true, silent = true}
  buf_map('n', '<c-]>', [[<cmd>lua require('j.plugins.lsp').definitions()<cr>]], opts)
  buf_map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  buf_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  buf_map('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_map('n', 'gr', [[<cmd>lua require'telescope.builtin'.lsp_references()<cr>]], opts)

  buf_map('n', 'K', [[<cmd>lua vim.lsp.buf.hover()<cr>]], opts)
  buf_map('n', '<space>rn', [[<cmd>lua vim.lsp.buf.rename()<CR>]], opts)
  buf_map('n', '<leader>ca', [[<cmd>lua vim.lsp.buf.code_action()<cr>]], opts)

  -- Navigate diagnostics
  buf_map('n', '[g', [[<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = 'single'}})<cr>]], opts)
  buf_map('n', ']g', [[<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = 'single'}})<cr>]], opts)
  -- Show diagnostics popup with <leader>d
  buf_map('n', '<leader>d', [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'single' })<cr>]], opts)

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[augroup LspFormatting]]
    vim.cmd [[autocmd! * <buffer>]]
    vim.cmd [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
    vim.cmd [[augroup END]]
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- Configure that we accept snippets so that the server would send us snippet 
-- completion items. Snippets are not supported by default, but 
-- `vim-vsnip-integ` adds support for them.
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
M.capabilities.textDocument.completion.completionItem.preselectSupport = true
M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
M.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
M.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
M.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
M.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }

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
    vim.api.nvim_err_writeln("Error when executing " .. action .. " : " .. err)
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

return M
