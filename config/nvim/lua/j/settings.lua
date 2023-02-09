local opt = vim.opt

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

-- Buffers
opt.hidden = true -- Buffer switching without saving

-- Search
opt.ignorecase = true -- Case insensitive search
opt.smartcase = true -- But sensitive if includes capital letter
opt.grepprg = 'rg --ignore-case --vimgrep'
opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'

opt.path = '**'
-- Ignore some folders and files with find
opt.wildignore = {
  '**/node_modules/**',
  '**/coverage/**',
  '**/.idea/**',
  '**/.git/**',
  '**/.nuxt/**',
}

-- UI
opt.wrap = false
opt.linebreak = true -- Break lines by spaces or tabs

opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.statuscolumn = "%C%=%4{&nu ? (&rnu ? (v:lnum == line('.') ? v:lnum . ' ' : v:relnum) : v:lnum) : ''}%=%s"
opt.showmode = false
opt.cmdheight = 0

opt.list = true
opt.listchars = {
  nbsp = '⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  tab = '  ',
  extends = '»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = '«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  trail = '·', -- Dot Operator (U+22C5)
}
-- Show cool character on line wrap
opt.showbreak = '↳ ' -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
opt.fillchars = {
  eob = ' ', -- Suppress ~ at EndOfBuffer
  fold = ' ', -- Hide trailing folding characters
  diff = '╱',
  foldopen = '',
  foldclose = '',
}

opt.cursorline = true -- Highlight current line
opt.colorcolumn = { 81, 121 } -- Highlight columns
opt.showmatch = true -- Highlight matching parenthesis, etc.

opt.showmode = false -- Do not show mode in command line

-- UX
opt.confirm = true
opt.updatetime = 100 -- Trigger cursorhold faster
opt.inccommand = 'nosplit' -- Show preview of ex commands

opt.splitright = true -- Open new split to the right
opt.splitbelow = true -- Open new split below
opt.splitkeep = 'screen'
opt.whichwrap = opt.whichwrap + 'h,l,<,>,[,]'
opt.joinspaces = false -- Prevent inserting two spaces with J

opt.completeopt = { 'menuone', 'noselect' } -- Completion menu
opt.pumheight = 13

--  Autoformatting
--  TODO: Might need to use concat because of
--  https://github.com/neovim/neovim/issues/14669
opt.formatoptions = table.concat {
  '2', -- Use the second line's indent vale when indenting (allows indented first line)
  'q', -- Formatting comments with `gq`
  'w', -- Trailing whitespace indicates a paragraph
  'j', -- Remove comment leader when makes sense (joining lines)
  'r', -- Insert comment leader after hitting Enter
  'o', -- Insert comment leader after hitting `o` or `O`
}

-- Messages
opt.shortmess:append {
  I = true, -- No splash screen
  W = true, -- Don't print "written" when editing
  a = true, -- Use abbreviations in messages ([RO] intead of [readonly])
  c = true, -- Do not show ins-completion-menu messages (match 1 of 2)
  F = true, -- Do not print file name when opening a file
  s = true, -- Do not show "Search hit BOTTOM" message
}

-- Integration with the system clipboard
opt.clipboard = { 'unnamed', 'unnamedplus' }

-- Navigation
opt.scrolloff = 5 -- Lines to scroll when cursor leaves screen
opt.sidescrolloff = 3 -- Lines to scroll horizontally
opt.suffixesadd = { '.md', '.js', '.ts', '.tsx' } -- File extensions not required when opening with `gf`

-- Backups
opt.backup = true
opt.backupdir = { vim.env.XDG_DATA_HOME .. '/nvim/backups' }
opt.backupskip = { '/tmp/*', '/private/tmp/*' }
opt.writebackup = true

-- Undo & History
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000
opt.shada = { '!', "'1000", '<50', 's10', 'h' } -- Increase the shadafile size so that history is longer

-- Sesssions
opt.sessionoptions:remove { 'buffers', 'folds' }
