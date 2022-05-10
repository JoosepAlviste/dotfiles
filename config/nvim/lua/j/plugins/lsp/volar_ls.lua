-- https://github.com/johnsoncodehk/volar
require('lspconfig').volar.setup {
  cmd = { 'volar-server', '--stdio' },
  on_attach = require('j.plugins.lsp').on_attach,
  capabilities = require('j.plugins.lsp').capabilities,
}
