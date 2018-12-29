"
" Leader mappings
"

nnoremap <Leader><Leader> <C-^> 	" Open last buffer

nnoremap <leader>q :quit<CR> 	" Quit the pane/buffer with <leader>q
nnoremap <leader>w :w!<CR> 	" Save with <leader>w

nnoremap <leader>/ za

" Useful mappings for managing tabs
noremap <leader>tn :tabnew<cr>
noremap <leader>to :tabonly<cr>
noremap <leader>tc :tabclose<cr>
noremap <leader>tm :tabmove
noremap <leader>t<leader> :tabnext

nnoremap <leader>k :echo @%<cr>         " Show relative filename

nnoremap <leader>o :only<CR>

