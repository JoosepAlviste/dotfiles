-- https://github.com/sumneko/lua-language-server
vim.lsp.config('lua_ls', {
  capabilities = require 'j.plugins.lsp.capabilities',
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
})
