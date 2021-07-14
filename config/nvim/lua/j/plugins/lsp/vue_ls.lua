-- https://github.com/vuejs/vetur/tree/master/server
require('lspconfig').vuels.setup{
  on_attach = function(client, bufnr)
    -- Disable the document formatting for vuels because we want to use efm 
    -- with ESLint
    client.resolved_capabilities.document_formatting = false

    require('j.plugins.lsp').on_attach(client, bufnr)
  end,
  capabilities = require('j.plugins.lsp').capabilities,
  settings = {
    vetur = {
      experimental = {
        templateInterpolationService = true,
      },
      validation = {
        templateProps = true,
      },
      completion = {
        tagCasing = 'initial',
        autoImport = true,
        useScaffoldSnippets = true,
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
}
