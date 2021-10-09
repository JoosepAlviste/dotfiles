-- https://github.com/johnsoncodehk/volar
require('lspconfig').volar.setup {
  on_attach = function(client, bufnr)
    -- Disable the document formatting for vuels because we want to use null-ls
    -- with ESLint
    client.resolved_capabilities.document_formatting = false

    require('j.plugins.lsp').on_attach(client, bufnr)
  end,
  capabilities = require('j.plugins.lsp').capabilities,
}
