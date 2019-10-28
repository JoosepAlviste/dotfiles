"
" Settings
"

setlocal formatoptions=ca2qwj


"
" Mappings
"

nnoremap <silent> <c-]> :call CocAction('jumpDefinition')<cr>

" When pressing Enter, make new line and indent as required
inoremap <expr> <CR> joosep#expand#expand()
