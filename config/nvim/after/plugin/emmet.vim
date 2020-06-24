"
" Mappings
"

inoremap <silent> <tab> <c-r>=<SID>ExpandTab()<cr>

let g:ulti_expand_or_jump_res = 0  " Default value, just set once
function! Ulti_ExpandOrJump_and_getRes()
  call UltiSnips#ExpandSnippetOrJump()
  return g:ulti_expand_or_jump_res
endfunction

function! s:ExpandTab()
  if Ulti_ExpandOrJump_and_getRes() > 0
    return ''
  elseif emmet#isExpandable()
    call emmet#util#closePopup()
    call emmet#expandAbbr(0, "")
    return "\<right>"
  else
    return "\<tab>"
  endif
endfunction
