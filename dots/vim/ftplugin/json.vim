nnoremap <buffer> o :call joosep#expand#insertComma()<cr>

" Support comments in JSON
autocmd FileType json syntax match Comment +\/\/.\+$+
