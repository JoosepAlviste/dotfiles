-- https://github.com/johnsoncodehk/volar
require('lspconfig').volar.setup {
  capabilities = require('j.plugins.lsp').capabilities,
  filetypes = { 'vue' },
  settings = {
    vue = {
      complete = {
        casing = {
          props = 'autoCamel',
        },
      },
    },
  },
}
