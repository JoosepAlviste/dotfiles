"
" Leader mappings
"

" Open last buffer
nnoremap <Leader><Leader> <C-^>

" Quit the pane/buffer with <leader>q
nnoremap <leader>q :quit<CR>
" Save with <leader>w
nnoremap <leader>w :w!<CR>

nnoremap <leader>/ za

" Useful mappings for managing tabs
noremap <leader>tn :tabnew<cr>
noremap <leader>to :tabonly<cr>
noremap <leader>tc :tabclose<cr>
noremap <leader>tm :tabmove<cr>
noremap <leader>t<leader> :tabnext<cr>

" Show relative filename
nnoremap <leader>k :echo @%<cr>

nnoremap <leader>o :only<CR>
