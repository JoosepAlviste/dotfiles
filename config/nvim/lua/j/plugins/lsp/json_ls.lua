-- https://github.com/vscode-langservers/vscode-json-languageserver
vim.lsp.config('jsonls', {
  settings = {
    json = {
      schemas = {
        { fileMatch = { 'jsconfig.json' }, url = 'https://json.schemastore.org/jsconfig' },
        { fileMatch = { 'tsconfig.json' }, url = 'https://json.schemastore.org/tsconfig' },
        { fileMatch = { 'package.json' }, url = 'https://json.schemastore.org/package' },
        {
          fileMatch = { '.prettierrc.json', '.prettierrc' },
          url = 'https://json.schemastore.org/prettierrc.json',
        },
        { fileMatch = { '.eslintrc.json' }, url = 'https://json.schemastore.org/eslintrc.json' },
      },
    },
  },
  capabilities = require 'j.plugins.lsp.capabilities',
})
vim.lsp.enable 'jsonls'
