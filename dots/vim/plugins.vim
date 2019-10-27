"
" Plug set up
"

" Automatically install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup installPlugins
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

" Initialize Plug
call plug#begin('~/.vim/plugged')


"
" Colors
"

Plug 'mhartington/oceanic-next'  " This colorscheme is customized a bit


"
" Utilities
"

" Use Ctrl+h/j/k/l to move between Kitty windows AND Vim splits
Plug 'knubie/vim-kitty-navigator'

Plug 'tpope/vim-repeat'  " Make the repeat (.) command smarter
Plug 'tpope/vim-surround'  " Surround stuff with braces, quotes, tags, anything
Plug 'tpope/vim-dispatch'  " Asynchronous jobs used by some plugins
Plug 'machakann/vim-highlightedyank'  " Highlight yanked text briefly
Plug 'tpope/vim-projectionist'  " Easily move between alternate files

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }  " File browser

Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
" FZF - fuzzy search everything - files, lines, commits, etc.
if executable('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf'
else
  " Install FZF if it is not installed already
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
Plug 'junegunn/fzf.vim'  " FZF Vim plugin for some configuration


"
" Programming
"

Plug 'tpope/vim-fugitive'  " Git integration
Plug 'tpope/vim-rhubarb'  " GitHub integration - use `hub` cli instead of `git`

Plug 'editorconfig/editorconfig-vim'  " Read .editorconfig file for settings

Plug 'alvan/vim-closetag'  " Automatically close tags
Plug 'tpope/vim-commentary'  " Comment stuff out easily
" Commentstring based on location in file - JSX & TSX have different comments
Plug 'suy/vim-context-commentstring'

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}  " VSCode features

" JavaScript

Plug 'neoclide/vim-jsx-improve'  " Javascript, JSX & indentation
Plug 'styled-components/vim-styled-components', {'branch': 'main'}

" Typescript

Plug 'HerringtonDarkholme/yats.vim'  " TypeScript syntax

" CSS

Plug 'cakebaker/scss-syntax.vim'

" Python

Plug 'numirias/semshi'


"
" Text editing
"

" LaTeX

Plug 'lervag/vimtex'  " LaTeX writing utilities
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }  " LaTeX preview `:LLP`


"
" DevIcons must be the last loaded plugin
"

Plug 'ryanoasis/vim-devicons'


"
" End initialization
"

call plug#end()
