"
" NERDTree pane Specific settings
"

setlocal signcolumn=no
setlocal colorcolumn=


"
" Mappings
"

" Move up a directory using "-" like vim-vinegar (usually "u" does this).
nmap <buffer> <expr> - g:NERDTreeMapUpdir

" Get rid of some weird symbols (maybe)
setlocal nolist
