" Appropriate tab size
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

setlocal iskeyword+=-


"
" Mappings
"

" Go to definition
nnoremap <silent> <c-]> :call CocAction('jumpDefinition')<cr>
