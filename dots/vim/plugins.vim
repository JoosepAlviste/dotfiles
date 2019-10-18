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
