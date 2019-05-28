" Appropriate tab size
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

" Format with prettier by default
setlocal formatprg=prettier

"
" Mappings
"

" Go to definition
nnoremap <silent> <c-]> :call CocAction('jumpDefinition')<cr>

" When pressing Enter, make new line and indent as required
inoremap <expr> <CR> joosep#expand#expand()

" Fix some highlighting problems in files with styled components
" See https://github.com/HerringtonDarkholme/yats.vim/issues/109
syntax sync fromstart
