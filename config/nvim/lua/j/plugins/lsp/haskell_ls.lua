require'lspconfig'.hls.setup{
  on_attach = require('j.plugins.lsp').on_attach,
  capabilities = require('j.plugins.lsp').capabilities,
}
