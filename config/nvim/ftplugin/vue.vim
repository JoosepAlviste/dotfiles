" CSS classes usually have dashes in them, so the whole class name should be 
" considered as a word
setlocal iskeyword+=-

" Mappings for navigating blocks
nnoremap <silent><buffer> ]] :call search('^<\(template\<bar>script\<bar>style\)', 'W')<cr>
nnoremap <silent><buffer> [[ :call search('^<\(template\<bar>script\<bar>style\)', 'bW')<cr>
