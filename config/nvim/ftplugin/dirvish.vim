"
" Settings
"

setlocal signcolumn=no
setlocal colorcolumn=


"
" Mappings
"

" Delete a file or folder
execute 'nnoremap <expr><buffer> <leader>d ":<C-u>silent !trash ".shellescape(fnamemodify(getline("."),":."))'
" Override the default Dirvish preview keybind
nnoremap <buffer> <c-p> <cmd>lua require('j.fzf').files()<cr>
nnoremap <buffer> <leader>n :e %
