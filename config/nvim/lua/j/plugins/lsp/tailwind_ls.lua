local is_npm_package_installed = require('j.utils').is_npm_package_installed

local have_tailwindish_styling = is_npm_package_installed 'windicss'

if have_tailwindish_styling then
  require('lspconfig').tailwindcss.setup {
    on_attach = require('j.plugins.lsp').on_attach,
    capabilities = require('j.plugins.lsp').capabilities,
  }
end
