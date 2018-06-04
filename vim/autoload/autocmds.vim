" Open last selected file in NERDTree when possible
function autocmds#attempt_select_last_file() abort
    let l:previous=expand('#:t')
    if l:previous != ''
        call search('\v<' . l:previous . '>')
    endif
endfunction

