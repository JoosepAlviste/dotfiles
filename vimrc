" # Plug {{{

" This needs to be first because if we want to use plugins (e.g., set a color
" scheme), the plugins aren't available yet. The plug#end method allows us to use plugins.

" Automatically install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Initialize Plug
call plug#begin('~/.vim/plugged')

" All Plug commands should be here
Plug 'joshdick/onedark.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'

" End Plug
call plug#end()

" }}}
" # Editor {{{

" Line numbers
set number

" Correct indentation
filetype on
filetype plugin on
filetype indent on
set tabstop=4
set shiftwidth=4
set expandtab smarttab
set softtabstop=0

" Highlight current line
set cursorline

" Highlight matching brace
set showmatch

" Scroll more when at the edge of screen
set scrolloff=3

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Syntax highlighting
syntax on

" Color scheme
colorscheme onedark

" }}}
" ## Search {{{

" Search as characters are written
set incsearch

" Highlight matches
set hlsearch

" Hide search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Smart uppercase
set ignorecase
set smartcase

" }}}
" ## Folding {{{
set foldenable

" Open most folds by default
set foldlevelstart=10

" Space to open/close folds
nnoremap <space> za

" Fold based on indent level
set foldmethod=indent
" }}}
" ## Splits {{{
set splitbelow
set splitright
" }}}
" ## File tree {{{
" Hide unneeded files and folders
"let g:netrw_list_hide = '^.*\.pyc$'

set wildignore+=.*\.pyc$

" }}}
" ## Keybindings {{{

" Remap leader to comma
let mapleader=","

" Move visually (in one wrapped line)
"nnoremap j gj
"nnoremap k gk

" Set jk to esc
inoremap jk <esc>

" Set jump to mark
nnoremap ' `
nnoremap ` '

" Longer history
set history=100

" Extended % matching
runtime macros/matchit.vim

" Scroll viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Easier pane movements
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Redraw 
nnoremap ® <C-l>

" Allow mouse actions (resize panes, etc.)
set mouse=a

" }}}
" # Vim specific {{{

" Visual autocomplete for command menu
set wildmenu

" Redraw only when need to
set lazyredraw

" Set backups to be written into /tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Enable hidden
set hidden

" Terminal window title
set title

" Visual bell
set visualbell

" }}}
" # File editing {{{
" Recursive :find
set path+=**
" Ignore some folders in find
set wildignore+=**/node_modules/**
set wildignore+=**/*.pyc
set wildignore+=**/vendor/**
set wildignore+=**/public/**
set wildignore+=**/dist/**
" }}}
" # Plugins {{{
" }}}
" ## Lightline {{{
" Use the onedark color scheme
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'filetype' ] ],
  \ },
  \ 'component_function': {
  \   'gitbranch': 'gitbranch#name',
  \ },
  \ }
" }}}
" ## Ale {{{

" Fixing
let g:ale_fix_on_save = 1
let g:ale_fixers = {
            \   'javascript': ['eslint'],
            \}

" }}}
" ## Load all plugins from pack {{{

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

" }}}
" # Overview {{{
set modelines=3
" Custom folding for this file
" vim:foldmethod=marker:foldlevel=0
" }}}

