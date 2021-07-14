-- https://github.com/theia-ide/typescript-language-server
require('lspconfig').tsserver.setup{
  on_attach = function(client, bufnr)
    -- Disable the document formatting for tsserver because we want to use efm 
    -- with ESLint
    client.resolved_capabilities.document_formatting = false

    require('j.plugins.lsp').on_attach(client, bufnr)
  end,
  capabilities = require('j.plugins.lsp').capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}
