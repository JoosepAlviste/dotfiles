nnoremap <buffer> o :call joosep#expand#insertComma()<cr>

inoremap <expr> <CR> joosep#expand#expand()

" Support comments in JSON
autocmd FileType json syntax match Comment +\/\/.\+$+
