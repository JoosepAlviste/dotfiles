-- https://github.com/vscode-langservers/vscode-json-languageserver
require('lspconfig').jsonls.setup {
  on_attach = require('j.plugins.lsp').on_attach,
  settings = {
    json = {
      schemas = {
        { fileMatch = { 'jsconfig.json' }, url = 'https://json.schemastore.org/jsconfig' },
        { fileMatch = { 'tsconfig.json' }, url = 'https://json.schemastore.org/tsconfig' },
        { fileMatch = { 'package.json' }, url = 'https://json.schemastore.org/package' },
        { fileMatch = { '.prettierrc.json', '.prettierrc' }, url = 'https://json.schemastore.org/prettierrc.json' },
      },
    },
  },
  capabilities = require('j.plugins.lsp').capabilities,
}
