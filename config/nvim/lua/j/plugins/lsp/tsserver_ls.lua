-- https://github.com/theia-ide/typescript-language-server
require('typescript').setup {
  server = {
    on_attach = require('j.plugins.lsp').on_attach,
    capabilities = require('j.plugins.lsp').capabilities,
  },
}
