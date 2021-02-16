" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/Users/joosep.alviste/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/joosep.alviste/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/joosep.alviste/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/joosep.alviste/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/joosep.alviste/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["material.vim"] = {
    loaded = true,
    path = "/Users/joosep.alviste/.local/share/nvim/site/pack/packer/start/material.vim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/joosep.alviste/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-fzf"] = {
    loaded = true,
    path = "/Users/joosep.alviste/.local/share/nvim/site/pack/packer/start/nvim-fzf"
  },
  ["nvim-fzf-commands"] = {
    loaded = true,
    path = "/Users/joosep.alviste/.local/share/nvim/site/pack/packer/start/nvim-fzf-commands"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/joosep.alviste/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/joosep.alviste/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["scoro.vim.git"] = {
    loaded = true,
    path = "/Users/joosep.alviste/.local/share/nvim/site/pack/packer/start/scoro.vim.git"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/joosep.alviste/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-kitty-navigator"] = {
    loaded = true,
    path = "/Users/joosep.alviste/.local/share/nvim/site/pack/packer/start/vim-kitty-navigator"
  },
  ["vim-vue"] = {
    loaded = true,
    path = "/Users/joosep.alviste/.local/share/nvim/site/pack/packer/start/vim-vue"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
