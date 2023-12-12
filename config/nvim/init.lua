local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require 'j.mappings'
require 'j.autocmds'
require 'j.settings'
require 'j.file_explorer'
require 'j.alternatives'
require 'j.statusline'
require 'j.tabline'

require('lazy').setup {
  import = 'j.plugins',
  install = {
    colorscheme = 'kanagawa',
  },
  dev = {
    path = '~/Code/Projects',
  },
}
