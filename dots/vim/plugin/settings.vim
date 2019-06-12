"
" Vim settings
"

set nocompatible    " Do not think about vi, warding off unexpected things

set expandtab   " Always use spaces instead of tabs
set shiftwidth=4        " Use indents of 4 spaces
set tabstop=4   " Indentation should be 4 spaces
set softtabstop=4       " Let backspace delete indentation

set mousehide   " Hide cursor when starting to type 

set hidden      " Buffer switching without saving

set hlsearch    " Highlight search results
set ignorecase  " Search is case insensitive
set smartcase   " But sensitive when uppercase letters are used

set wildmode=list:longest,full
set path+=**    " Recursive find
" Ignore some folders and files in find
set wildignore+=**/node_modules/**
set wildignore+=**/*.pyc
set wildignore+=**/vendor/**
set wildignore+=**/public/**
set wildignore+=**/dist/**
set wildignore+=**/.git/**
set wildignore+=**/.DS_Store

" Instead of failing a command because of unsaved changes, raise
" a dialogue asking if you wish to save changed files.
set confirm

" Set backups to be written into temp folders
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

if has('persistent_undo')
    " Save the undo tree when exiting a buffer
    set undofile
    " Number of changes that can be undone
    set undolevels=1000
    " Lines to save for undo on a buffer reload
    set undoreload=10000
endif

set updatetime=100      " Update faster

set foldenable  " Enable folding, auto fold code


"
" Controls
"

set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap lines

set mouse=a     " Enable mouse usage

" Lines to scroll when cursor leaves screen
set scrolloff=3

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

set backspace=indent,eol,start  " Make backspace work normally
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap lines

set completeopt+=noinsert       " Do not insert first completion option automatically

set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags

set nojoinspaces        " Prevent inserting two spaces with J

set splitright  " Open new splits to the right
set splitbelow  " Open new splits below


"
" Graphical
"

" Show relative line numbers and current line's absolute number
set number
if exists('+relativenumber')
    set relativenumber
endif

set signcolumn=yes                    " Always show sign column or it might flicker

set list                              " Show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:⇥\ 
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:⋅                " Dot Operator (U+22C5)
" Show cool character on line wrap
if has('linebreak')
  let &showbreak='↳ '                 " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
endif

" Enable true-color
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

set shortmess+=I        " No splash screen
set shortmess+=W        " Don't print "written" when writing
set shortmess+=a        " Use abbreviations in messages ([RO] instead of [readonly])
set shortmess+=o        " Overwrite file-written messages
if has("patch-7.4.314")
    set shortmess+=c    " Do not show ins-completion-menu messages (match 1 of 2, Pattern not found, etc.)
endif

set cursorline  " Highlight current line
" Disable cursorline in diff mode
autocmd OptionSet diff let &cursorline=!v:option_new

set colorcolumn=81,121  " Highlight columns
set showmatch   " Highlight matching parenthesis, etc.

set lazyredraw  " Redraw only when need to

set visualbell  " Use visual bell instead of beeping

set cmdheight=2

if has('folding')
  set foldmethod=indent         " not as cool as syntax, but faster
  set foldlevelstart=99         " start unfolded
  set foldtext=joosep#settings#foldtext()
endif

if has('windows')
  set fillchars=vert:┃        " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: 
                              " E2 94 83)
  set fillchars+=fold:·       " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
endif

if has('nvim-0.3.1')
  set fillchars+=eob:\  " suppress ~ at EndOfBuffer
endif
