function! joosep#specialfiles#opencmd() abort
  " Linux/BSD
  if executable("xdg-open")
    return "xdg-open"
  endif
  " MacOS
  if executable("open")
    return "open"
  endif
  " Windows
  return "explorer"
endfunction

" Open the current file with xdg-open or open
function! joosep#specialfiles#openspecial() abort
  call system(joosep#specialfiles#opencmd() . " " . expand("%:p")) | buffer# | bdelete# | redraw!
endfunction
