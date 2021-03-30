function! joosep#open#open_url_under_cursor()
  let s:uri = expand('<cWORD>')
  " If the cursor is on a markdown link (e.g., '[test](https://google.com)'), 
  " then parse the URL from there
  let s:uri = matchstr(s:uri, '[a-z]*:\/\/[^ >,;)]*')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!open '" . s:uri . "'"
    redraw!
  endif
endfunction
