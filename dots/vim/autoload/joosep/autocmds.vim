" Open last selected file in NERDTree when possible
function! joosep#autocmds#attempt_select_last_file() abort
  let l:previous=expand('#:t')
  if l:previous != ''
    call search('\v<' . l:previous . '>')
  endif
endfunction

function! joosep#autocmds#blur_window() abort
    if exists('+winhighlight')
        let disabledBufTypes = ['nofile', 'nowrite', 'acwrite', 'quickfix', 'help']
        let disabledFileTypes = ['startify']
        let bt = &buftype
        let ft = &filetype
        if index(disabledBufTypes, bt) == -1 
            \ && index(disabledFileTypes, ft) == -1
            set winhighlight=CursorLineNr:LineNr,EndOfBuffer:ColorColumn,Normal:ColorColumn,SignColumn:ColorColumn
        endif
    endif
endfunction

function! joosep#autocmds#focus_window() abort
    if exists('+winhighlight')
        set winhighlight=
    endif
endfunction
