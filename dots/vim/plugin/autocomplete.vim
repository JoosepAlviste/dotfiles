if has('nvim')
  " inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  " inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-j>"
  inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
  inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
endif
