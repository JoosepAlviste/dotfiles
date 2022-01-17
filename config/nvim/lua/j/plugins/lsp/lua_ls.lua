-- https://github.com/sumneko/lua-language-server
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

local luadev = require('lua-dev').setup {
  lspconfig = {
    on_attach = require('j.plugins.lsp').on_attach,
    capabilities = require('j.plugins.lsp').capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  },
}

require('lspconfig').sumneko_lua.setup(luadev)
