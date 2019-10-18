" Appropriate tab size
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

" Format with prettier by default
setlocal formatprg=prettier\ --parser\ typescript

" Set errorformat for working with vim-test, neomake, and the
" jest-vim-reporter
" TODO: This should probably NOT be set like this -- maybe vim-test can be
" improved somehow
setlocal errorformat=%f:%l:%c:\ %m

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
