local util = require 'lspconfig.util'

require('lspconfig').eslint.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true

    require('j.plugins.lsp').on_attach(client, bufnr)
  end,
  root_dir = util.root_pattern('.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', '.eslintrc'),
}
