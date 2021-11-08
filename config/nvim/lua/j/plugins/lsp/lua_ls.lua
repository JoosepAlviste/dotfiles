-- https://github.com/sumneko/lua-language-server
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

local luadev = require('lua-dev').setup {
  lspconfig = {
    on_attach = require('j.plugins.lsp').on_attach,
    capabilities = require('j.plugins.lsp').capabilities,
    cmd = { 'lua-language-server', '-E', vim.fn.expand '$HOME/Code/Programs/lua-language-server/main.lua' },
    flags = {
      debounce_text_changes = 150,
    },
  },
}

require('lspconfig').sumneko_lua.setup(luadev)
