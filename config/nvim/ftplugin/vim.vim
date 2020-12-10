"
" Settings
"

setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2


"
" Mappings
"

" Go to definition
if has_key(plugs, 'coc.nvim')
  nnoremap <silent> <c-]> :call CocAction('jumpDefinition')<cr>
endif
