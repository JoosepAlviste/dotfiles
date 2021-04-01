local g = vim.g
local o = vim.o

local utils = require('j.utils')
local opt = utils.opt
local map = utils.map
local create_augroups = utils.create_augroups

-- Can save global functions to this table
_G.MUtils = {}


-- Settings

-- Map space to leader
map('n', '<space>', '<nop>')
map('v', '<space>', '<nop>')
g.mapleader = ' '
g.maplocalleader = '\\'

local buffer = {o, vim.bo}
local window = {o, vim.wo}

-- Indentation
opt('expandtab', true, buffer)
opt('shiftwidth', 2, buffer)
opt('tabstop', 2, buffer)
opt('softtabstop', 2, buffer)

-- Buffers
opt('hidden')  -- Buffer switching without saving

-- Search
opt('ignorecase')  -- Case insensitive search
opt('smartcase')  -- But sensitive if includes capital letter
opt('grepprg', 'rg --ignore-case --vimgrep')
opt('grepformat', '%f:%l:%c:%m,%f:%l:%m')

opt('path', '**') -- temp
-- Ignore some folders and files with find
opt('wildignore', {
  '**/node_modules/**',
  '**/coverage/**',
  '**/.idea/**',
  '**/.git/**',
  '**/.nuxt/**',
})

-- UI
opt('wrap', false, window)
opt('linebreak', true, window)  -- Break lines by spaces or tabs

opt('number', true, window)
opt('relativenumber', true, window)
opt('signcolumn', 'yes', window)
opt('showmode', false)

opt('list', true, window)
opt('listchars', {
  'nbsp:⦸',  -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  'tab:  ',
  'extends:»',  -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  'precedes:«',  -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  'trail:·',  -- Dot Operator (U+22C5)
}, window)
-- Show cool character on line wrap
opt('showbreak', '↳ ')  -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
opt('fillchars', 'eob: ')  -- Suppress ~ at EndOfBuffer

opt('cursorline', true, window)  -- Highlight current line
opt('colorcolumn', {81, 121}, window)  -- Highlight columns
opt('showmatch')  -- Highlight matching parenthesis, etc.

opt('lazyredraw')  -- Redraw only when need to

opt('showmode', false)  -- Do not show mode in command line

-- UX
opt('confirm')
opt('updatetime', 100)  -- Trigger cursorhold faster
opt('inccommand', 'nosplit')  -- Show preview of ex commands

opt('mouse', 'a')  -- Enable mouse usage
opt('splitright')  -- Open new split to the right
opt('splitbelow')  -- Open new split below
opt('whichwrap', 'b,s,h,l,<,>,[,]')  -- Backspace and cursor keys wrap lines
opt('joinspaces', false)  -- Prevent inserting two spaces with J

opt('completeopt', {'menuone', 'noselect'})  -- Completion menu

--  Autoformatting
opt('formatoptions', {
  'c',  -- Auto-wrap comments
  'a',  -- Auto format paragraph
  '2',  -- Use the second line's indent vale when indenting (allows indented first line)
  'q',  -- Formatting comments with `gq`
  'w',  -- Trailing whitespace indicates a paragraph
  'j',  -- Remove comment leader when makes sense (joining lines)
  'r',  -- Insert comment leader after hitting Enter
  'o',  -- Insert comment leader after hitting `o` or `O`
}, buffer)

-- Messages
local short_mess = 'filnxtToOF'
short_mess = short_mess .. 'I'  -- No splash screen
short_mess = short_mess .. 'W'  -- Don't print "written" when editing
short_mess = short_mess .. 'a'  -- Use abbreviations in messages ([RO] intead of [readonly])
short_mess = short_mess .. 'c'  -- Do not show ins-completion-menu messages (match 1 of 2)
opt('shortmess', short_mess)

-- Integration with the system clipboard
opt('clipboard', 'unnamed,unnamedplus')

-- Navigation
opt('scrolloff', 3)  -- Lines to scroll when cursor leaves screen
opt('sidescrolloff', 3)  -- Lines to scroll horizontally
opt('suffixesadd', '.md,.js,.ts,.tsx')  -- File extensions not required when opening with `gf`

-- Backups
opt('backup')
opt('backupdir', '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp')
opt('backupskip', '/tmp/*,/private/tmp/*')
opt('writebackup')

-- Undo & History
opt('undofile')
opt('undolevels', 1000)
opt('undoreload', 10000)
opt('shada', '!,\'1000,<50,s10,h')  -- Increase the shadafile size so that history is longer


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

require('nvim-web-devicons').setup({
  override = {
    graphql = {
      icon = '',
      color = '#e535ab',
      name = 'GraphQL',
    },
  },
})

-- My custom configurations
require('j.plugins')
require('j.mappings')
require('j.abbreviations')
require('j.statusline').setup()
require('j.tabline').setup()
require('j.file_info').setup()
require('j.terminal').setup()
require('j.folding').setup()
require('j.session').setup()


-- Plugin configurations
require('j.plugins.lsp').setup()
require('j.plugins.completion').setup()
require('j.plugins.fzf').setup()
require('j.plugins.autopairs').setup()
require('j.plugins.kommentary').setup()
require('j.plugins.material').setup()
require('j.plugins.treesitter').setup()
require('colorizer').setup()
require('j.plugins.gitsigns').setup()
require('j.plugins.vsnip').setup()
require('j.plugins.dirvish').setup()
require('j.plugins.editorconfig').setup()
