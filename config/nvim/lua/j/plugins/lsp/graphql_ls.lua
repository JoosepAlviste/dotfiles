-- https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-cli
vim.lsp.config('graphql', {
  capabilities = require 'j.plugins.lsp.capabilities',
  root_markers = { { '.graphqlrc.yml', '.graphqlrc' }, '.git' },
  filetypes = { 'graphql', 'typescriptreact' },
})
vim.lsp.enable 'graphql'
