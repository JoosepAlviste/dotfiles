-- https://github.com/johnsoncodehk/volar
local read_package_json = require('j.utils').read_package_json

local package_json = read_package_json()

require('lspconfig').volar.setup {
  cmd = { 'volar-server', '--stdio' },
  on_attach = require('j.plugins.lsp').on_attach,
  capabilities = require('j.plugins.lsp').capabilities,
  filetypes = package_json and package_json.dependencies.vue and { 'vue', 'typescript' } or { 'vue' },
}
