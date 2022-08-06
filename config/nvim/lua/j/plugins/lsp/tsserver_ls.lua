-- https://github.com/theia-ide/typescript-language-server
local read_package_json = require('j.utils').read_package_json

local package_json = read_package_json()

local have_vue = package_json and package_json.dependencies.vue

if not have_vue then
  require('typescript').setup {
    server = {
      on_attach = require('j.plugins.lsp').on_attach,
      capabilities = require('j.plugins.lsp').capabilities,
    },
  }
end
