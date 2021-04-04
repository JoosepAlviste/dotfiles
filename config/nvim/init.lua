local g = vim.g

local map = require('j.utils').map

-- Can save global functions to this table
_G.MUtils = {}


-- Map space to leader
map('n', '<space>', '<nop>')
map('v', '<space>', '<nop>')
g.mapleader = ' '
g.maplocalleader = '\\'

-- My custom configurations
require('j.settings')
require('j.commands')
require('j.autocmds')
require('j.plugins')
require('j.mappings')
require('j.abbreviations')
require('j.plugins.web_devicons') -- Set up icons before statusline
require('j.statusline')
require('j.tabline')
require('j.file_info')
require('j.terminal')
require('j.folding')
require('j.session').setup()


-- Plugin configurations
require('j.plugins.lsp')
require('j.plugins.completion')
require('j.plugins.fzf')
require('j.plugins.autopairs')
require('j.plugins.kommentary')
require('j.plugins.material').setup()
require('j.plugins.treesitter')
require('colorizer').setup({
  '*',
  '!packer',
})
require('j.plugins.gitsigns')
require('j.plugins.vsnip')
require('j.plugins.dirvish')
require('j.plugins.editorconfig')
require('j.plugins.projectionist')
require('j.plugins.tree')
