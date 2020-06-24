"
" Settings
"

setlocal signcolumn=no
setlocal colorcolumn=


"
" Mappings
"

" Move the currently hovered file/folder
nnoremap <expr><buffer> <leader>m <SID>Move()
" Create a new file or folder (trailing `/` means folder)
nnoremap <buffer> <leader>n :NewFile 
" Delete the given file/folder
execute 'nnoremap <expr><buffer> <leader>d ":<C-u>silent !trash ".shellescape(fnamemodify(getline("."),":."))'
" Open the file in the current split with `o`
nnoremap <nowait><buffer><silent> o :<C-U>.call dirvish#open('edit', 0)<CR>

" Override the default Dirvish preview keybind
nnoremap <buffer><silent> <C-p> :FZF<cr>

" Show a prompt to move the file that the cursor is currently on
function! s:Move()
  let l:extension = fnamemodify(getline('.'), ':e')
  let l:extension_len = strlen(l:extension) + 2  " Add `'` and `.`
  let l:go_left = repeat("\<left>", l:extension_len)

  let l:current_file = shellescape(fnamemodify(getline('.'), ':.'))
  let l:destination = shellescape(getline('.'))

  return ":\<C-u>Move " . l:current_file . ' ' . l:destination . l:go_left
endfunction
