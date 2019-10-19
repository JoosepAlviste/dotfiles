function! joosep#expand#expand()
  " Make a double new line and indent correctly if the cursor is between a
  " start and end tag

  let line   = getline(".")
  let col    = col(".")
  let first  = line[col-2]
  let second = line[col-1]
  let third  = line[col]

  if first ==# ">" || first ==# "`"
    if (second ==# "<" && third ==# "/") || (second ==# "`")
      return "\<CR>\<C-o>==\<C-o>O"
    else
      return "\<CR>"
    endif
  else
    return "\<CR>"
  endif
endfunction

function! joosep#expand#insertComma()
    " When creating a new line with o, make sure there is a trailing comma on
    " the current line

    " Add the trailing comma if it doesn't exist
    substitute/\(.*[^{[][^,{[]\)$/\1,/g
    " And add the new line
    call feedkeys("A\<cr>")
endfunction
