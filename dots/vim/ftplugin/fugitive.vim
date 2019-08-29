setlocal signcolumn=no

" Open commit message vertically
nnoremap <buffer> <silent> ca    :<C-U>vertical Gcommit --amend<CR>O
nnoremap <buffer> <silent> cc    :<C-U>vertical Gcommit<CR>O
