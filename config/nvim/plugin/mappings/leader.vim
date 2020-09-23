"
" Leader mappings
"

" Open last buffer
nnoremap <leader><leader> <C-^>

" Quit the pane/buffer with <leader>q
nnoremap <silent> <leader>q :quit<cr>
" Quit Vim without closing windows (useful for keeping a session)
nnoremap <silent> <leader>x :quitall<cr>
" Save with <leader>w
nnoremap <silent> <leader>w :w!<cr>

nnoremap <leader>e :e <C-R>=substitute(expand('%:p:h').'/', getcwd().'/', '', '')<cr>

" Useful mappings for managing tabs
noremap <silent> <leader>tn :tabnew<cr>
noremap <silent> <leader>to :tabonly<cr>
noremap <silent> <leader>tc :tabclose<cr>
noremap <silent> <leader>tm :tabmove<cr>

nnoremap <leader>o :only<cr>

" Source the configuration file
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

nnoremap <silent> <localleader>x :nohlsearch<cr>

" Search & replace word under cursor
nnoremap <leader>sr :%s/\<<C-r><C-w>\>/

" Change the open project quickly
nnoremap <leader>p :Project!<cr>
