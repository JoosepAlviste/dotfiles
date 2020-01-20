" Provide useful functionality for handling quickfix lists.
" From https://vimways.org/2018/colder-quickfix-lists/

function! s:isLocation()
  " Get dictionary of properties of the current window
  let wininfo = filter(getwininfo(), {i,v -> v.winnr == winnr()})[0]
  return wininfo.loclist
endfunction

function! s:length()
  " Get the size of the current quickfix/location list
  return len(s:isLocation() ? getloclist(0) : getqflist())
endfunction

function! s:getProperty(key, ...)
  " getqflist() and getloclist() expect a dictionary argument
  " If a 2nd argument has been passed in, use it as the value, else 0
  let l:what = {a:key : a:0 ? a:1 : 0}
  let l:listdict = s:isLocation() ? getloclist(0, l:what) : getqflist(l:what)
  return get(l:listdict, a:key)
endfunction

function! s:isFirst()
  return s:getProperty('nr') <= 1
endfunction

function! s:isLast()
  return s:getProperty('nr') == s:getProperty('nr', '$')
endfunction

function! s:history(goNewer)
  " Build the command: one of colder/cnewer/lolder/lnewer
  let l:cmd = (s:isLocation() ? 'l' : 'c') . (a:goNewer ? 'newer' : 'older')

  " Apply the cmd repeatedly until we hit a non-empty list, or first/last list
  " is reached
  while 1
    if (a:goNewer && s:isLast()) || (!a:goNewer && s:isFirst()) | break | endif
    " Run the command. Use :silent to suppress message-history output.
    " Note that the :try wrapper is no longer necessary
    silent execute l:cmd
    if s:length() | break | endif
  endwhile

  " Set the height of the quickfix window to the size of the list, max-height 10
  execute 'resize' min([ 10, max([ 1, s:length() ]) ])

  " Echo a description of the new quickfix / location list.
  " And make it look like a rainbow.
  let l:nr = s:getProperty('nr')
  let l:last = s:getProperty('nr', '$')
  echohl MoreMsg | echon '('
  echohl Identifier | echon l:nr
  if l:last > 1
    echohl LineNr | echon ' of '
    echohl Identifier | echon l:last
  endif
  echohl MoreMsg | echon ') '
  echohl MoreMsg | echon '['
  echohl Identifier | echon s:length()
  echohl MoreMsg | echon '] '
  echohl Normal | echon s:getProperty('title')
  echohl None
endfunction

function! joosep#quickfixed#older()
  call s:history(0)
endfunction

function! joosep#quickfixed#newer()
  call s:history(1)
endfunction
