local util = require 'lspconfig.util'

require('lspconfig').eslint.setup {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
  end,
  root_dir = util.root_pattern('.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', '.eslintrc'),
}
