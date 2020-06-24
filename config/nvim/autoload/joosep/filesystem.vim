" Create a file or folder to the given path. If the path ends with a `/`, then 
" a directory is created with that name.
function! joosep#filesystem#create_file_or_folder(path)
  let l:is_directory = a:path[strlen(a:path) - 1] ==# '/'
  let l:parent_directory = a:path
  if !l:is_directory
    let l:parent_directory = fnamemodify(a:path, ':h')
  endif

  execute 'silent !mkdir -p %/' .. l:parent_directory

  if !l:is_directory
    execute 'silent !touch %/' .. a:path
  endif
endfunction

" Move the given file (`a:from`) to the given destination (`a:to`) and create 
" folders as necessary
" `a:from` is assumed to be a shell-escaped relative path from `pwd`
" `a:to` is assumed to be a shell-escaped absolute path
function! joosep#filesystem#move(from, to)
  let l:to = trim(a:to, "'")
  let l:folder = shellescape(fnamemodify(l:to, ':h'))
  execute 'silent !mkdir -p ' .. l:folder
  execute 'silent !mv ' .. a:from .. ' ' .. a:to
endfunction
