local create_augroups = require('j.utils').create_augroups

-- Highlight line numbers for diagnostics
vim.fn.sign_define('LspDiagnosticsSignError', {numhl = 'LspDiagnosticsLineNrError', text = ''})
vim.fn.sign_define('LspDiagnosticsSignWarning', {numhl = 'LspDiagnosticsLineNrWarning', text = ''})
vim.fn.sign_define('LspDiagnosticsSignInformation', {text = ''})
vim.fn.sign_define('LspDiagnosticsSignHint', {text = ''})

-- Configure diagnostics displaying
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = '»',
      spacing = 4,
      severity_limit = 'Warning',
    },
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
    if bufnr == vim.api.nvim_get_current_buf() then
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

create_augroups({
  lsp = {
    {'BufWrite,BufEnter,InsertLeave', '*', [[lua require('j.plugins.lsp').add_diagnostics_to_loclist()]]},
  },
})

-- Construct some utilities that are needed for setting up the LSP servers

local M = {}

function M.on_attach(client, bufnr)
  local function buf_map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Set up keymaps
  local opts = {noremap = true, silent = true}
  buf_map('n', '<c-]>', '<cmd>Telescope lsp_definitions<cr>', opts)
  buf_map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  buf_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  buf_map('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_map('n', 'gr', [[<cmd>lua require'telescope.builtin'.lsp_references()<cr>]], opts)

  buf_map('n', 'K', [[<cmd>lua vim.lsp.buf.hover()<cr>]], opts)
  buf_map('n', '<space>rn', [[<cmd>lua vim.lsp.buf.rename()<CR>]], opts)
  buf_map('n', '<leader>ca', [[<cmd>lua vim.lsp.buf.code_action()<cr>]], opts)

  -- Navigate diagnostics
  buf_map('n', '[g', [[<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>]], opts)
  buf_map('n', ']g', [[<cmd>lua vim.lsp.diagnostic.goto_next()<cr>]], opts)
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

function M.add_diagnostics_to_loclist()
  vim.lsp.diagnostic.set_loclist({open_loclist = false})
end

return M
