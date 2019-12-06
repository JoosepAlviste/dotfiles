"
" Settings
"

setlocal omnifunc=csscomplete#CompleteCSS
setlocal iskeyword+=-


"
" Mappings
"

" Go to definition
nnoremap <silent> <c-]> :call CocAction('jumpDefinition')<cr>
