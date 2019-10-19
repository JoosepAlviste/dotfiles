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

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}  " VSCode features

" Typescript

Plug 'HerringtonDarkholme/yats.vim'  " TypeScript syntax


"
" DevIcons must be the last loaded plugin
"

Plug 'ryanoasis/vim-devicons'


"
" End initialization
"

call plug#end()
