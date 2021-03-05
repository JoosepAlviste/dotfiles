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
" Delete a file or folder
nnoremap <expr><buffer> <leader>d ":<C-u>silent !trash ".shellescape(fnamemodify(getline("."),":."))
" Override the default Dirvish preview keybind
nnoremap <buffer> <c-p> <cmd>lua require('j.fzf').files()<cr>

" Grep inside the hovered folder
nnoremap <buffer> <leader>ff <cmd>lua require('j.fzf').grep_folder(vim.fn.fnamemodify(vim.fn.getline('.'), ':.'))<cr>

" Show a prompt to move the file that the cursor is currently on
function! s:Move()
  let l:file = fnameescape(getline('.'))

  " The files to populate the prompt with
  let l:current_file = shellescape(fnamemodify(l:file, ':.'))
  let l:destination = shellescape(l:file)

  " Calculate how many times to go left to position the cursor in a 
  " comfortable place for editing (before the file extension)
  let l:extension = fnamemodify(l:file, ':e')
  let l:extension_len = strlen(l:extension) + 2  " Add `'` and `.`
  let l:go_left = repeat("\<left>", l:extension_len)

  return ":\<C-u>Move " .. l:current_file .. ' ' .. l:destination .. l:go_left
endfunction
