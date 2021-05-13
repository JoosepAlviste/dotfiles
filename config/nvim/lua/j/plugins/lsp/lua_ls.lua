-- https://github.com/sumneko/lua-language-server
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
-- https://gist.github.com/folke/fe5d28423ea5380929c3f7ce674c41d8

-- Calculate the path for the Sumneko language server
local system_name
if vim.fn.has('mac') == 1 then
  system_name = 'macOS'
elseif vim.fn.has('unix') == 1 then
  system_name = 'Linux'
elseif vim.fn.has('win32') == 1 then
  system_name = 'Windows'
else
  print('Unsupported system for sumneko')
end
local sumneko_root_path = vim.fn.expand('$HOME') .. '/Programs/lua-language-server'
local sumneko_binary = sumneko_root_path..'/bin/' .. system_name .. '/lua-language-server'

-- Calculate paths to add for the language server to analyse

local library = {}

local path = vim.split(package.path, ';')

table.insert(path, 'lua/?.lua')
table.insert(path, 'lua/?/init.lua')

local function add(lib)
  for _, p in pairs(vim.fn.expand(lib, false, true)) do
    p = vim.loop.fs_realpath(p)
    library[p] = true
  end
end

-- Runtime
add('$VIMRUNTIME')
-- My config
add('~/.config/nvim')
-- Plugins
add('~/.local/share/nvim/site/pack/packer/opt/*')
add('~/.local/share/nvim/site/pack/packer/start/*')

require('lspconfig').sumneko_lua.setup {
  on_attach = require('j.plugins.lsp').on_attach,
  cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = path,
      },
      diagnostics = {
        globals = {'vim'},
        disable = {'trailing-space'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = library,
        maxPreload = 2000,
        preloadFileSize = 50000
      },
      completion = {callSnippet = 'Both'},
      telemetry = {enable = false}
    },
  },
  capabilities = require('j.plugins.lsp').capabilities,
  -- Delete root from workspace to make sure we don't trigger duplicate 
  -- warnings
  on_new_config = function(config, root)
    local libs = vim.tbl_deep_extend('force', {}, library)
    libs[root] = nil
    config.settings.Lua.workspace.library = libs
    return config
  end,
}
