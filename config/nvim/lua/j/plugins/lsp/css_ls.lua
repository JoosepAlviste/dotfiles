-- https://github.com/vscode-langservers/vscode-css-languageserver-bin
require('lspconfig').cssls.setup {
  on_attach = require('j.plugins.lsp').on_attach,
  capabilities = require('j.plugins.lsp').capabilities,
  settings = {
    css = {
      lint = {
        -- Do not warn for Tailwind's @apply rule
        unknownAtRules = 'ignore',
      },
    },
  },
}
