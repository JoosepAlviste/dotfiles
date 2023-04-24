-- https://github.com/valentjn/ltex-ls
require('lspconfig').ltex.setup {
  cmd = { vim.env.HOME .. '/Code/Programs/ltex-ls/bin/ltex-ls' },
  capabilities = require('j.plugins.lsp').capabilities,
}
