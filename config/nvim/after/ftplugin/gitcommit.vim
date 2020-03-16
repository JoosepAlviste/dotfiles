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

" Navigate between changed files
nnoremap <silent> <buffer> { ?^@@<CR>
nnoremap <silent> <buffer> } /^@@<CR>


"
" Run commands when file is loaded
"

" Automatically insert issue number as Git commit message prefix
call joosep#git#insert_issue_prefix()
