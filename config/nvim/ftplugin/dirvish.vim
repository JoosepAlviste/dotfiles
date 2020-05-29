"
" Settings
"

setlocal signcolumn=no
setlocal colorcolumn=


"
" Mappings
"

" Move the currently hovered file/folder
execute 'nnoremap <expr><buffer> <leader>m ":<C-u>silent !mv ".shellescape(fnamemodify(getline("."),":."))." ".expand("%")'
" Create a new file or folder (trailing `/` means folder)
nnoremap <buffer> <leader>n :NewFile 
" Delete the given file/folder
execute 'nnoremap <expr><buffer> <leader>d ":<C-u>silent !trash ".shellescape(fnamemodify(getline("."),":."))'
" Open the file in the current split with `o`
nnoremap <nowait><buffer><silent> o :<C-U>.call dirvish#open('edit', 0)<CR>

" Override the default Dirvish preview keybind
nnoremap <buffer><silent> <C-p> :FZF<cr>
