" Appropriate tab size
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

setlocal include=^\\s*[^\/]\\+\\(from\\\|require(['\"]\\)
setlocal define=\\(class\\s\\\|const\\s\\\|function\\s\\)

setlocal foldmethod=syntax

"
" Mappings
"

" Go to definition
nnoremap <silent> <c-]> :call CocAction('jumpDefinition')<cr>

" Fix some highlighting problems in files with styled components
" See https://github.com/HerringtonDarkholme/yats.vim/issues/109
syntax sync fromstart

" Plugin settings

let b:pear_tree_pairs = {
      \ '<*>': {'closer': '</*>', 'not_like': '/$'},
      \ }
