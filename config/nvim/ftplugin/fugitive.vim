"
" Settings
"

setlocal signcolumn=no


"
" Mappings
"

" Open commit message vertically so that status and commit splits have more
" vertical room
nnoremap <buffer> <silent> ca :<C-U>vertical Gcommit --amend<CR>
nnoremap <buffer> <silent> cc :<C-u>vertical Gcommit<CR>
nnoremap <buffer> <silent> cw :<C-U>vertical Gcommit --amend --only<CR>


"
" Plugin settings
"

HardTimeOff
