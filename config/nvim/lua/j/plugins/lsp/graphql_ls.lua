-- https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-cli
require('lspconfig').graphql.setup{
  on_attach = require('j.plugins.lsp').on_attach,
  capabilities = require('j.plugins.lsp').capabilities,
}
