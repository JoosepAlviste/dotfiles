" Appropriate tab size
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

" Format with prettier by default
setlocal formatprg=prettier\ --parser\ typescript

"
" Mappings
"

" Go to definition
nnoremap <silent> <c-]> :TSDef<cr>

" When pressing Enter, make new line and indent as required
inoremap <expr> <CR> joosep#expand#expand()
