"
" Vim settings
"

set nocompatible  " Do not think about vi, warding off unexpected things 

set expandtab  " Always use spaces instead of tabs
set shiftwidth=4  " Use indents of 4 spaces
set tabstop=4  " Indentation should be 4 spaces
set softtabstop=4  " Let backspace delete indentation

set hidden  " Buffer switching without saving

set ignorecase  " Search is case insensitive
set smartcase  " But sensitive when uppercase letters are used

set path+=**  " Recursive find
set path-=/usr/include
" Ignore some folders and files with find
set wildignore+=**/node_modules/**
set wildignore+=**/*.pyc
set wildignore+=**/vendor/**
set wildignore+=**/public/**
set wildignore+=**/dist/**
set wildignore+=**/.git/**
set wildignore+=**/.DS_Store
set wildignore+=**/build/**
set wildignore+=**/_build/**

set wildcharm=<C-z>

set grepprg=rg\ --ignore-case\ --vimgrep
set grepformat=%f:%l:%c:%m,%f:%l:%m

" Instead of failing a command because of unsaved changes, raise a dialogue 
" asking if you wish to save changed files.
set confirm

" Set backups to be written into temp folders
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

if has('persistent_undo')
  set undofile  " Save the undo tree when exiting a buffer
  set undolevels=1000  " Number of changes that can be undone
  set undoreload=10000  " Lines to save for undo on a buffer reload
endif

set updatetime=100  " Trigger cursorhold faster, save swap file faster

set autoread    " Automatically update buffer when file changes

set nowrap  " Do not wrap lines by default
set linebreak  " Break lines by spaces or tabs

if has('nvim')
  set inccommand=nosplit  " Show preview of ex commands
endif

" Increase the shadafile size so that the history is longer
set shada=!,'1000,<50,s10,h


"
" Controls
"

set mouse=a  " Enable mouse usage

set scrolloff=3  " Lines to scroll when cursor leaves screen
set sidescrolloff=5  " Lines to scroll horizontally when cursor leaves screen

" Integration with the system clipboard
if has('clipboard')
  if has('unnamedplus')
    " When possible, use the + register for copy/paste
    set clipboard=unnamed,unnamedplus
  else
    " On Mac and Windows, use the * register
    set clipboard=unnamed
  endif
endif

set splitright  " Open new splits to the right
set splitbelow  " Open new splits below

set whichwrap=b,s,h,l,<,>,[,]  " Backspace and cursor keys wrap lines

set nojoinspaces  " Prevent inserting two spaces with J

set suffixesadd=.md,.js,.ts,.tsx  " File extensions not required when opening with `gf`


"
" Vim UI
"

" Show relative line numbers and current line's absolute number
set number
if exists('+relativenumber')
  set relativenumber
endif

set signcolumn=yes  " Always show sign column or it might flicker

" Whitespace & special symbols
set list  " Show whitespace
set listchars=nbsp:⦸  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:\ \ 
set listchars+=extends:»  " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«  " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:·  " Dot Operator (U+22C5)
if has('linebreak')
  " Show cool character on line wrap
  let &showbreak='↳ '  " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
endif

" Messages
set shortmess+=I  " No splash screen
set shortmess+=W  " Don't print "written" when writing
set shortmess+=a  " Use abbreviations in messages ([RO] instead of [readonly])
set shortmess+=o  " Overwrite file-written messages
if has("patch-7.4.314")
  set shortmess+=c  " Do not show ins-completion-menu messages (match 1 of 2, Pattern not found, etc.)
endif

set cursorline  " Highlight current line
set colorcolumn=81,121  " Highlight columns
set showmatch  " Highlight matching parenthesis, etc.

set lazyredraw  " Redraw only when need to

if has('folding')
  set foldenable  " Enable folding, auto fold code
  set foldmethod=indent  " Not as cool as syntax, but faster
  set foldlevelstart=99  " Start unfolded
  set foldtext=joosep#settings#foldtext()
endif

if has('windows')
  set fillchars=vert:┃  " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  set fillchars+=fold:·  " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
endif

if has('nvim-0.3.1')
  set fillchars+=eob:\  " suppress ~ at EndOfBuffer
endif

if (has('termguicolors'))
  set termguicolors  " Enable true colors
endif

" Use fancier cursor shapes
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0
set guicursor+=i-ci:ver25-Cursor/lCurso
set guicursor+=r-cr-o:hor20-Cursor/lCursor

" Make PUM a bit transparent
set pumblend=9

" Improve completion UX a bit
set completeopt=menu,menuone,noselect


"
" Editing
"

" Autoformatting
set formatoptions=
set formatoptions+=c  " Auto-wrap comments
set formatoptions+=a  " Auto format paragraph
set formatoptions+=2  " Use the second line's indent value when indenting (allows indented first line)
set formatoptions+=q  " Formatting comments with `gq`
set formatoptions+=w  " Trailing whitespace indicates a paragraph
set formatoptions+=j  " Remove comment leader when makes sense (joining lines)
set formatoptions+=r  " Insert comment leader after hitting Enter
set formatoptions+=o  " Insert comment leader after hitting `o` or `O`


"
" Terminal
"

if has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
  set termwinkey=<c-_>
endif

" Fix the colors of the terminal
if has('nvim')
  " Copied colors from Palenight Kitty theme
  let g:terminal_color_0  = '#292D3E'
  let g:terminal_color_1  = '#F07178'
  let g:terminal_color_2  = '#C3E88D'
  let g:terminal_color_3  = '#FFCB6B'
  let g:terminal_color_4  = '#82AAFF'
  let g:terminal_color_5  = '#C792EA'
  let g:terminal_color_6  = '#89DDFF'
  let g:terminal_color_7  = '#7982B4'
  let g:terminal_color_8  = '#4e5579'
  let g:terminal_color_9  = '#FF8B92'
  let g:terminal_color_10 = '#DDFFA7'
  let g:terminal_color_11 = '#FFE585'
  let g:terminal_color_12 = '#9CC4FF'
  let g:terminal_color_13 = '#E1ACFF'
  let g:terminal_color_14 = '#A3F7FF'
  let g:terminal_color_15 = '#FFFFFF'
endif
