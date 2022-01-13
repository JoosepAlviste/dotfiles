-- https://github.com/valentjn/ltex-ls
require('lspconfig').ltex.setup {
  cmd = { vim.env.HOME .. '/Code/Programs/ltex-ls/bin/ltex-ls' },
  on_attach = require('j.plugins.lsp').on_attach,
  capabilities = require('j.plugins.lsp').capabilities,
}
