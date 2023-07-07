-- https://github.com/bufbuild/buf-language-server
require('lspconfig').bufls.setup {
  capabilities = require('j.plugins.lsp').capabilities,
}
