local g = vim.g

local map = require('j.utils').map

-- Map space to leader
map('n', '<space>', '<nop>')
map('v', '<space>', '<nop>')
g.mapleader = ' '
g.maplocalleader = '\\'

-- My custom configurations
require 'j.settings'
require 'j.commands'
require 'j.autocmds'
require 'j.plugins'
require 'j.mappings'
require 'j.abbreviations'
require 'j.plugins.web_devicons' -- Set up icons before statusline
require 'j.statusline'
require 'j.tabline'
require 'j.file_info'
require 'j.terminal'
require 'j.folding'
