-- https://intelephense.com
require('lspconfig').intelephense.setup {
  on_attach = require('j.plugins.lsp').on_attach,
  capabilities = require('j.plugins.lsp').capabilities,
  settings = {
    intelephense = {
      environment = {
        shortOpenTag = true,
      },
    },
  },
}
