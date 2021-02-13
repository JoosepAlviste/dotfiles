"
" Settings
"

setlocal signcolumn=no


"
" Mappings
"

" Open commit message vertically so that status and commit splits have more
" vertical room
nnoremap <buffer> <silent> ca :<C-U>vertical Git commit --amend<CR>
nnoremap <buffer> <silent> cc :<C-u>vertical Git commit<CR>
nnoremap <buffer> <silent> cw :<C-U>vertical Git commit --amend --only<CR>
