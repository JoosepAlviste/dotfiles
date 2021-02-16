local g = vim.g
local o = vim.o
local cmd = vim.cmd

local utils = require('j.utils')
local opt = utils.opt
local map = utils.map

-- Can save global functions to this table
_G.MUtils = {}


-- Settings

-- Map space to leader
map('n', '<space>', '<nop>')
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
opt('wildignore', '**/node_modules/**,**/coverage/**,**/.idea/**,**/.git/**,**/.nuxt/**')

-- UI
opt('wrap', false, window)
opt('linebreak', true, window)  -- Break lines by spaces or tabs

opt('number', true, window)
opt('relativenumber', true, window)
opt('signcolumn', 'yes', window)

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

-- UX
opt('confirm')
opt('updatetime', 100)  -- Trigger cursorhold faster
opt('inccommand', 'nosplit')  -- Show preview of ex commands

opt('mouse', 'a')  -- Enable mouse usage
opt('splitright')  -- Open new split to the right
opt('splitbelow')  -- Open new split below
opt('whichwrap', 'b,s,h,l,<,>,[,]')  -- Backspace and cursor keys wrap lines
opt('joinspaces', false)  -- Prevent inserting two spaces with J

opt('foldmethod', 'indent', window)
opt('foldlevelstart', 99)

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
short_mess = short_mess .. 'W'  -- Don't pring "written" when editing
short_mess = short_mess .. 'a'  -- Use abbreviations in messages ([RO] intead of [readonly])
short_mess = short_mess .. 'c'  -- Do not show ins-completion-menu messages (match 1 of 2)
opt('shortmess', short_mess)

-- Integration with the system clipboard
if vim.fn.has('unnamedplus') == 1 then
  -- When possible, use the + register for copy/paste
  opt('clipboard', 'unnamed,unnamedplus')
else
  -- On Mac and Windows, use the * register
  opt('clipboard', 'unnamed')
end

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


-- Require files
require('j.plugins')
require('j.mappings')
require('j.lsp').setup()

require('j.fzf').setup()
require('j.autopairs').setup()
require('j.fugitive').setup()


-- Colorscheme

o.termguicolors = true

g.material_terminal_italics = true
g.material_theme_style = 'palenight'
cmd [[colorscheme material]]


-- Autocommands

cmd [[augroup JoosepAutocmds]]
cmd [[autocmd!]]
cmd [[autocmd BufWritePost plugins.lua PackerCompile]]
cmd [[augroup END]]
