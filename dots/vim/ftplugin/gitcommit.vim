"
" Settings
"

" No line numbers
setlocal norelativenumber
setlocal nonumber
setlocal signcolumn=no

setlocal textwidth=72
setlocal colorcolumn=73,51

" Autoformatting
setlocal formatoptions-=c  " Enable formatting everywhere, not just comments

setlocal spell
setlocal iskeyword+=-


"
" Mappings
"

nnoremap <silent> <buffer> { ?^@@<CR>
nnoremap <silent> <buffer> } /^@@<CR>
