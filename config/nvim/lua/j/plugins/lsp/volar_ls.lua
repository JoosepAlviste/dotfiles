-- https://github.com/johnsoncodehk/volar
local is_npm_package_installed = require('j.utils').is_npm_package_installed

require('lspconfig').volar.setup {
  on_attach = require('j.plugins.lsp').on_attach,
  capabilities = require('j.plugins.lsp').capabilities,
  filetypes = is_npm_package_installed 'vue' and { 'vue', 'typescript', 'javascript' } or { 'vue' },
}
