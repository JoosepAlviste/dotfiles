-- https://github.com/theia-ide/typescript-language-server
local is_npm_package_installed = require('j.utils').is_npm_package_installed

local have_vue = is_npm_package_installed 'vue'

if not have_vue then
  require('typescript-tools').setup()
end
