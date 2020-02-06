"
" Leader mappings
"

" Open last buffer
nnoremap <leader><leader> <C-^>

" Quit the pane/buffer with <leader>q
nnoremap <silent> <leader>q :quit<cr>
" Save with <leader>w
nnoremap <silent> <leader>w :w!<cr>

nnoremap <leader>e :e <C-R>=substitute(expand('%:p:h').'/', getcwd().'/', '', '')<cr>

" Useful mappings for managing tabs
noremap <silent> <leader>tn :tabnew<cr>
noremap <silent> <leader>to :tabonly<cr>
noremap <silent> <leader>tc :tabclose<cr>
noremap <silent> <leader>tm :tabmove<cr>
noremap <silent> <leader>t<leader> :tabnext<cr>

" Show relative filename
nnoremap <leader>k :echohl Identifier \| echon @% \| echohl None<cr>

nnoremap <leader>o :only<cr>

" Source the configuration file
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

nnoremap <localleader>x :nohlsearch<cr>
