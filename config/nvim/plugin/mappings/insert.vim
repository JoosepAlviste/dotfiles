"
" Insert mode mappings
"

inoremap jk <esc>
" Some typos I often make that should also change to normal mode
inoremap Jk <esc>
inoremap JK <esc>

" Might help with floating window not disappearing completely
inoremap <C-c> <esc>

" Navigate panes in insert mode
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
