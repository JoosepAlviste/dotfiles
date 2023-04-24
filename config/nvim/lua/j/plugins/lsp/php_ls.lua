-- https://intelephense.com
require('lspconfig').intelephense.setup {
  capabilities = require('j.plugins.lsp').capabilities,
  settings = {
    intelephense = {
      environment = {
        shortOpenTag = true,
      },
    },
  },
}
