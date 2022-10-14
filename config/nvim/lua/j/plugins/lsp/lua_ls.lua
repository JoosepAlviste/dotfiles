-- https://github.com/sumneko/lua-language-server
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

require('neodev').setup {}

require('lspconfig').sumneko_lua.setup {
  on_attach = require('j.plugins.lsp').on_attach,
  capabilities = require('j.plugins.lsp').capabilities,
  settings = {
    Lua = {
      format = {
        enable = false,
      },
    },
  },
}
