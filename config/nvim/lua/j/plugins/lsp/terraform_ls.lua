require('lspconfig').terraformls.setup {
  capabilities = require('j.plugins.lsp').capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}
