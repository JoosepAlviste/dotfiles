require'lspconfig'.terraformls.setup{
  filetypes = {'terraform', 'tf'},
  capabilities = require('j.plugins.lsp').capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}
