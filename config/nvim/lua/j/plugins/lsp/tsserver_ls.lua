-- https://github.com/theia-ide/typescript-language-server
local is_npm_package_installed = require('j.utils').is_npm_package_installed
local is_marketer_repo = require('j.modash').is_marketer_repo

local have_vue = is_npm_package_installed 'vue'

if not have_vue and not is_marketer_repo() then
  require('typescript-tools').setup {}
end
