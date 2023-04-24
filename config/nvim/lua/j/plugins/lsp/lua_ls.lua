-- https://github.com/sumneko/lua-language-server
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

require('neodev').setup {}

require('lspconfig').lua_ls.setup {
  capabilities = require('j.plugins.lsp').capabilities,
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      workspace = {
        checkThirdParty = false,
      },
    },
  },
}
