-- https://github.com/vscode-langservers/vscode-css-languageserver-bin
vim.lsp.config('cssls', {
  capabilities = require 'j.plugins.lsp.capabilities',
  settings = {
    css = {
      lint = {
        -- Do not warn for Tailwind's @apply rule
        unknownAtRules = 'ignore',
      },
    },
  },
})
vim.lsp.enable 'cssls'
