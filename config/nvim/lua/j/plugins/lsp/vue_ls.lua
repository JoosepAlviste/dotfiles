-- https://github.com/johnsoncodehk/volar
vim.lsp.config('vue_ls', {
  capabilities = require('j.plugins.lsp').capabilities,
  settings = {
    vue = {
      complete = {
        casing = {
          props = 'autoCamel',
        },
      },
    },
  },
})
vim.lsp.enable 'vue_ls'
