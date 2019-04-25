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
nnoremap <silent> <c-]> :call CocAction('jumpDefinition')<cr>

" When pressing Enter, make new line and indent as required
" inoremap <expr> <CR> joosep#expand#expand()

" nnoremap <silent> <leader>i :TSImport<cr>

" Disable Deoplete since we have coc.nvim
call deoplete#custom#buffer_option('auto_complete', v:false)
