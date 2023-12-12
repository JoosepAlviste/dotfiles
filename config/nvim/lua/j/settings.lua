-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Search
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- But sensitive if includes capital letter
vim.opt.grepprg = 'rg --ignore-case --vimgrep'
vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'

vim.opt.path = '**'
-- Ignore some folders and files with find
vim.opt.wildignore = {
  '**/node_modules/**',
  '**/coverage/**',
  '**/.idea/**',
  '**/.git/**',
  '**/.nuxt/**',
}

-- UI
vim.opt.wrap = false
vim.opt.linebreak = true -- Break lines by spaces or tabs

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.statuscolumn =
  "%C%=%4{&nu && v:virtnum <= 0 ? (&rnu ? (v:lnum == line('.') ? v:lnum . ' ' : v:relnum) : v:lnum) : ''}%=%s"
vim.opt.showmode = false

vim.opt.list = true
vim.opt.listchars = {
  nbsp = '⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  tab = '  ',
  extends = '»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = '«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  trail = '·', -- Dot Operator (U+22C5)
}
-- Show cool character on line wrap
vim.opt.showbreak = '↳ ' -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
vim.opt.fillchars = {
  eob = ' ', -- Suppress ~ at EndOfBuffer
  fold = ' ', -- Hide trailing folding characters
  diff = '╱',
  foldopen = '',
  foldclose = '',
}

vim.opt.cursorline = true -- Highlight current line
vim.opt.colorcolumn = { 81, 121 } -- Highlight columns

vim.opt.showmode = false -- Do not show mode in command line

-- Folds
vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'

-- UX
vim.opt.confirm = true
vim.opt.updatetime = 100 -- Trigger cursorhold faster

vim.opt.splitright = true -- Open new split to the right
vim.opt.splitbelow = true -- Open new split below
vim.opt.splitkeep = 'screen'
vim.opt.whichwrap = vim.opt.whichwrap + 'h,l,<,>,[,]'

vim.opt.completeopt = { 'menuone', 'noselect' } -- Completion menu
vim.opt.pumheight = 13

--  Autoformatting
--  TODO: Can we get rid of concat here?
vim.opt.formatoptions = table.concat {
  '2', -- Use the second line's indent vale when indenting (allows indented first line)
  'q', -- Formatting comments with `gq`
  'w', -- Trailing whitespace indicates a paragraph
  'j', -- Remove comment leader when makes sense (joining lines)
  'r', -- Insert comment leader after hitting Enter
  'o', -- Insert comment leader after hitting `o` or `O`
}

-- Messages
vim.opt.shortmess:append {
  I = true, -- No splash screen
  W = true, -- Don't print "written" when editing
  a = true, -- Use abbreviations in messages ([RO] intead of [readonly])
  c = true, -- Do not show ins-completion-menu messages (match 1 of 2)
  F = true, -- Do not print file name when opening a file
  s = true, -- Do not show "Search hit BOTTOM" message
}

-- Integration with the system clipboard
vim.opt.clipboard = { 'unnamed', 'unnamedplus' }

-- Navigation
vim.opt.scrolloff = 5 -- Lines to scroll when cursor leaves screen
vim.opt.sidescrolloff = 3 -- Lines to scroll horizontally
vim.opt.suffixesadd = { '.md', '.js', '.ts', '.tsx' } -- File extensions not required when opening with `gf`

-- Backups
vim.opt.backup = true
vim.opt.backupdir = { vim.env.XDG_DATA_HOME .. '/nvim/backups' }
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.writebackup = true

-- Undo & History
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.shada = { '!', "'1000", '<50', 's10', 'h' } -- Increase the shadafile size so that history is longer

-- Sesssions
vim.opt.sessionoptions:remove { 'buffers', 'folds' }
