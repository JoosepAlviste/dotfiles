" # Modeline {
" Rules only for this file
" vim: set sw=2 ts=2 sts=2 tw=78 foldmarker={,} foldmethod=marker spell:
" }
" # Plug setup {

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

" }
" # Install plugins {
" ## Generic {

" Use Ctrl+h/j/k/l to move between Kitty windows AND Vim splits
Plug 'knubie/vim-kitty-navigator'

Plug 'tpope/vim-sensible'  " Sensible defaults

Plug 'jiangmiao/auto-pairs'  " Automatically insert closing-parenthesis
Plug 'tpope/vim-repeat'  " Make the repeat (.) command smarter
Plug 'tpope/vim-surround'  " Surround stuff with braces, quotes, tags, anything
Plug 'tpope/vim-dispatch'  " Asynchronous jobs used by some plugins
Plug 'machakann/vim-highlightedyank'  " Highlight yanked text briefly
Plug 'tpope/vim-projectionist'  " Easily move between alternate files

Plug 'Yggdroot/indentLine'  " Show fancy indentation guides
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }  " File browser
Plug 'itchyny/lightline.vim'  " Only the tab line (I use a custom statusline)
Plug 'mhinz/vim-startify'  " Start screen that looks nice and shows recent files

Plug 'metakirby5/codi.vim'  " Interactive scratchpad thingy that runs JavaScript

" FZF - fuzzy search everything - files, lines, commits, etc.
if executable('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf'
else
  " Install FZF if it is not installed already
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
Plug 'junegunn/fzf.vim'  " FZF Vim plugin for some configuration


" }
" ## Colors {

Plug 'mhartington/oceanic-next'  " This colorscheme is customized a bit


" }
" ## Programming {

Plug 'tpope/vim-fugitive'  " Git integration
Plug 'tpope/vim-rhubarb'  " GitHub integration - use `hub` cli instead of `git`

Plug 'editorconfig/editorconfig-vim'  " Read .editorconfig file for settings

Plug 'tpope/vim-commentary'  " Comment stuff out easily
Plug 'ludovicchabant/vim-gutentags'  " Manage tags file automagically

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}  " VSCode features
Plug 'w0rp/ale'  " Automatic linting

Plug 'neomake/neomake'  " Show tests output with virtualtext (with vim-test)
Plug 'janko/vim-test'  " Easily run test file/suite & show result with Neomake

Plug 'sheerun/vim-polyglot'  " Syntax highlighting for most file types
" commentstring based on location in file - JSX & TSX have different comments
Plug 'suy/vim-context-commentstring'

" Show package version info with virtualtext (npm, Pipfile, etc.)
Plug 'meain/vim-package-info', { 'do': 'npm install' }

" JavaScript & friends
Plug 'HerringtonDarkholme/yats.vim'  " TypeScript syntax
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'othree/yajs.vim'  " Fancier JavaScript syntax
Plug 'maxmellon/vim-jsx-pretty'  " JSX syntax, this cannot be active in TS files

Plug 'jparise/vim-graphql'  " GraphQL highlighting

Plug 'ap/vim-css-color'  " Show hex code color as background


" }
" ## Text editing {

" Preview Markdown files
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

Plug 'lervag/vimtex'  " LaTeX writing utilities
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }  " LaTeX preview `:LLP`


" Always load this last!
Plug 'ryanoasis/vim-devicons'  " Icons for file types, etc.


" }
" }
" # End initialization {
call plug#end()

" }
