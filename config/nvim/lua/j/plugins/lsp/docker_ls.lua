-- https://github.com/rcjsuen/dockerfile-language-server-nodejs
vim.lsp.config('dockerls', {
  capabilities = require 'j.plugins.lsp.capabilities',
})
vim.lsp.enable 'dockerls'
