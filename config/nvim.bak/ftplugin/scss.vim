"
" Settings
"

setlocal omnifunc=csscomplete#CompleteCSS
setlocal iskeyword+=-


"
" Mappings
"

" Go to definition
if has_key(plugs, 'coc.nvim')
  nnoremap <silent> <c-]> :call CocAction('jumpDefinition')<cr>
endif