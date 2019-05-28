" # Modeline {
" Rules only for this file
" vim: set sw=2 ts=2 sts=2 tw=78 foldmarker={,} foldmethod=marker spell:
" }
" # Plug setup {

" Automatically install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Initialize Plug
call plug#begin('~/.vim/plugged')

" }
" # Install plugins {

" Nicer TMUX pane movements
Plug 'christoomey/vim-tmux-navigator'

Plug 'tpope/vim-sensible'

Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-repeat'   " Allows to make the repeat (.) command smarter
Plug 'tpope/vim-surround'   " Surround stuff with braces, quotes, tags, anything
Plug 'machakann/vim-highlightedyank'  " Highlight yanked text briefly

Plug 'dhruvasagar/vim-zoom'  " TMUX-like zooming of panes

Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'

" FZF - fuzzy search
if executable('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
Plug 'junegunn/fzf.vim'


"
" Colors
"

Plug 'mhartington/oceanic-next'


"
" Programming
"

Plug 'tpope/vim-commentary'   " Comment stuff out easily
Plug 'sheerun/vim-polyglot'   " Syntax highlighting for most file types
Plug 'ludovicchabant/vim-gutentags'   " Manage tags file

Plug 'tpope/vim-fugitive'   " Git integrations
" Plug 'airblade/vim-gitgutter'   " Show Git modified lines in the gutter

Plug 'editorconfig/editorconfig-vim'

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

Plug 'HerringtonDarkholme/yats.vim'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Plug 'pangloss/vim-javascript'
" Plug 'maxmellon/vim-jsx-pretty'   " Nicer JSX syntax highlighting

Plug 'jparise/vim-graphql'

Plug 'ap/vim-css-color'

Plug 'alvan/vim-closetag'

Plug 'w0rp/ale'


"
" Text editing
"

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" LaTeX
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }


" Always load this last!
Plug 'ryanoasis/vim-devicons'


" End initialization
call plug#end()

" }
