" Open last selected file in NERDTree when possible
function joosep#autocmds#attempt_select_last_file() abort
    let l:previous=expand('#:t')
    if l:previous != ''
        call search('\v<' . l:previous . '>')
    endif
endfunction


" Highlight the currently hovered word everywhere in the file
function joosep#autocmds#highlight_hovered_item() abort
    exe printf('match lCursor /\V\<%s\>/', escape(expand('<cword>'), '/\'))
endfunction

