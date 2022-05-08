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
setlocal formatoptions+=ca  " Enable formatting everywhere, not just comments

setlocal spell
setlocal iskeyword+=-


"
" Plugin settings
"

let b:EditorConfig_disable = 1


"
" Mappings
"

" Navigate between changed files
nnoremap <silent> <buffer> { ?^@@<CR>
nnoremap <silent> <buffer> } /^@@<CR>
