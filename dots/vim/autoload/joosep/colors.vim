" Utility function to apply highlighting colors to syntax groups
function! joosep#colors#hi(group, fg, bg, attr, attrsp)
    if !empty(a:fg)
        exec "hi " . a:group . " guifg=" .  a:fg[0]
        exec "hi " . a:group . " ctermfg=" . a:fg[1]
    endif
    if !empty(a:bg)
        exec "hi " . a:group . " guibg=" .  a:bg[0]
        exec "hi " . a:group . " ctermbg=" . a:bg[1]
    endif
    if a:attr != ""
        exec "hi " . a:group . " gui=" .   a:attr
        exec "hi " . a:group . " cterm=" . a:attr
    endif
    if !empty(a:attrsp)
        exec "hi " . a:group . " guisp=" . a:attrsp[0]
    endif
endfunction

" Utility function for setting highlights but without `cterm` colors
function! joosep#colors#hiSimple(group, fg, bg, attr, attrsp)
  let l:attr = a:attr

  if empty(l:attr)
    let l:attr = 'none'
  endif

  if !empty(a:fg)
    exec 'hi ' . a:group . ' guifg=' . a:fg
  endif

  if !empty(a:bg)
    exec 'hi ' . a:group . ' guibg=' . a:bg
  endif

  if !empty(l:attr)
    exec 'hi ' . a:group . ' gui=' . l:attr . ' cterm=' . l:attr
  endif

  if !empty(a:attrsp)
      exec "hi " . a:group . " guisp=" . a:attrsp
  endif
endfun
