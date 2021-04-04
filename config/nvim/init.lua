local g = vim.g

local utils = require('j.utils')
local map = utils.map
local create_augroups = utils.create_augroups

-- Can save global functions to this table
_G.MUtils = {}


-- Map space to leader
map('n', '<space>', '<nop>')
map('v', '<space>', '<nop>')
g.mapleader = ' '
g.maplocalleader = '\\'


-- Commands

vim.cmd [[command! -nargs=1 NewFile call joosep#filesystem#create_file_or_folder(<f-args>)]]
vim.cmd [[command! -nargs=+ Move call joosep#filesystem#move(<f-args>)]]


-- Autocommands

create_augroups({
  setup = {
    -- Automatically compile packer when saving the plugins' file
    {'BufWritePost', 'plugins.lua', 'PackerCompile'},
    -- Highlight text after yanking
    {'TextYankPost', '*', [[lua require('vim.highlight').on_yank({ higroup = 'Substitute', timeout = 200 })]]},
    -- Hide cursorline in insert mode
    {'InsertLeave,WinEnter', '*', 'set cursorline'},
    {'InsertEnter,WinLeave', '*', 'set nocursorline'},
    -- Automatically close Vim if the quickfix window is the only one open
    {'WinEnter', '*', [[if winnr('$') == 1 && &buftype == 'quickfix' | q | endif]]},
    -- Automatically update changed file in Vim
    -- Triger `autoread` when files changes on disk
    -- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
    -- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    {
      'FocusGained,BufEnter,CursorHold,CursorHoldI',
      '*',
      [[silent! if mode() != 'c' | checktime | endif]],
    },
    -- Notification after file change
    -- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
    {
      'FileChangedShellPost',
      '*',
      [[echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]],
    },
  },
  -- Simple one-liner filetype specific things that I don't really want to put 
  -- into ftplugin files for whatever reason
  simple_filetypes = {
    -- The `typescriptreact` FileType autocmd gets executed BEFORE the 
    -- `ftplugin` file. However, we need to set the commentstring before any 
    -- other FileType autocmds
    {'FileType', 'typescriptreact', [[setlocal commentstring=//\ %s]]},
    {'FileType', 'vue', [[setlocal commentstring=<!--\ %s\ -->]]},
    -- Open images automatically
    {'FileType', 'image', [[lua require('j.filesystem').open_special_file()]]},
  },
})

-- My custom configurations
require('j.settings')
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
