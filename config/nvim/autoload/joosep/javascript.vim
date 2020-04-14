" Add a return statement to an implicit return arrow function
function! joosep#javascript#add_return()
  let line = getline('.')
  if line =~# '=> ({$'
    call feedkeys(":s/=> (/=> {\\r\<cr>ireturn \<esc>}k:s/)//\<cr>a\<cr>}\<esc>=ip")
  elseif line =~# '=> ($'
    call feedkeys(":s/=> (/=> {\<cr>jIreturn \<esc>j^r}")
  elseif line =~# '=> [$'
    call feedkeys("$i{\<cr>return \<esc>l%a\<cr>}\<esc>=ip")
  elseif line =~# '=>$'
    call feedkeys("A {\<esc>:s/{}$/{\<cr>jIreturn \<esc>}o}\<esc>=ip")
  else
    call feedkeys(":s/=> /=> {\\r\<cr>Ireturn \<esc>o}\<esc>=ip")
  endif
endfunction
