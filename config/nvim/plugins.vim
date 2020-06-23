"
" Plug set up
"

" Automatically install Plug
if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Initialize Plug
call plug#begin(stdpath('data') . '/plugged')


"
" Colors
"

Plug 'kaicataldo/material.vim'
" Plug 'jacoborus/tender.vim'


"
" Vim core utilities
" ==================
" These plugins should improve Vim in subtle ways.
"

" Core improvements
Plug 'tpope/vim-repeat'  " Make the repeat (.) command smarter
Plug 'tpope/vim-dispatch'  " Asynchronous jobs used by some plugins
Plug 'farmergreg/vim-lastplace'  " Restore cursor position when opening a file

" Custom text objects
Plug 'kana/vim-textobj-user'  " Library for custom text objects
Plug 'kana/vim-textobj-indent'  " Indentation based ai/ii
Plug 'kana/vim-textobj-line'  " Entire line al/il
Plug 'kana/vim-textobj-entire'  " Entire file ae/ie
Plug 'vim-scripts/argtextobj.vim'  " Function arguments with aa/ia

" Useful mapping improvements
Plug 'machakann/vim-sandwich'  " Surround stuff with things
Plug 'tpope/vim-projectionist'  " Easily move between alternate files
Plug 'tmsvg/pear-tree'  " Better auto-pairs
Plug 'junegunn/vim-slash'  " Improve searching
Plug 'andymass/vim-matchup'  " Improved %
Plug 'mcchrish/info-window.nvim'  " Improved <C-g>


"
" Big plugins
" ===========
" These plugins have big effects on how I use Vim.
" For example, this includes things like language servers, file navigation, 
" etc.
"

" FZF - fuzzy search everything - files, lines, commits, etc.
Plug $HOME . '/.config/fzf'
Plug 'junegunn/fzf.vim'  " FZF Vim plugin for some configuration

" Autocompletion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}  " VSCode features into Vim
Plug 'neovim/nvim-lsp'
Plug 'haorenW1025/completion-nvim'
Plug 'dense-analysis/ale'

" Snippets
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'  " Currently this seems to be a bit broken
Plug 'SirVer/ultisnips'

" UI extras
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'psliwka/vim-smoothie'  " Smooth scrolling

" External programs
Plug 'skywind3000/vim-terminal-help'
Plug 'metakirby5/codi.vim'  " Fast scratchpad like Numi
" Use Ctrl+h/j/k/l to move between Kitty windows AND Vim splits
Plug 'knubie/vim-kitty-navigator'


"
" Programming
" ===========
" Things related to programming. Mostly filetype plugins but also some that 
" are relevant to programming in general.
"

" Git related things
Plug 'tpope/vim-fugitive'  " Git integration
Plug 'tpope/vim-rhubarb'  " GitHub integration - use `hub` cli instead of `git`
Plug 'shumphrey/fugitive-gitlab.vim'  " GitLab integration for Fugitive
Plug 'tpope/vim-git'  " Git related files' syntax
Plug 'airblade/vim-gitgutter'  " Git hunks in the sign column

Plug 'editorconfig/editorconfig-vim'  " Read .editorconfig file for settings

Plug 'tpope/vim-commentary'  " Comment stuff out easily
" Commentstring based on location in file - JSX & TSX have different comments
Plug 'JoosepAlviste/vim-context-commentstring'


" Typescript

Plug 'HerringtonDarkholme/yats.vim'  " TypeScript syntax

" JavaScript

Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" CSS

Plug 'hail2u/vim-css3-syntax'  " Improved CSS3 syntax
Plug 'cakebaker/scss-syntax.vim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Python

Plug 'vim-python/python-syntax'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}  " Semantic highlighting
Plug 'Vimjas/vim-python-pep8-indent'  " Better indentation
Plug 'jeetsukumaran/vim-pythonsense'  " Python text objects & motions

" GraphQL

Plug 'jparise/vim-graphql'


"
" Text editing
"

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" LaTeX

Plug 'lervag/vimtex'  " LaTeX writing utilities


" Markdown

Plug 'godlygeek/tabular'  " Required by markdown
Plug 'plasticboy/vim-markdown'


" CSV

Plug 'chrisbra/csv.vim'


" End initialization
call plug#end()
