" Open last selected file in NERDTree when possible
function! joosep#autocmds#attempt_select_last_file() abort
    let l:previous=expand('#:t')
    if l:previous != ''
        call search('\v<' . l:previous . '>')
    endif
endfunction

" Prevent opening files in NERDTree view
function! joosep#autocmds#prevent_buffers_in_nerd_tree()
    if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree'
                \ && exists('t:nerdtree_winnr') && bufwinnr('%') == t:nerdtree_winnr
                \ && &buftype == '' && !exists('g:launching_fzf')
        let bufnum = bufnr('%')
        try
            " Do not close the buffer if it is the only one
            close
        catch
        endtry
        exe 'b ' . bufnum
    endif
    if exists('g:launching_fzf') | unlet g:launching_fzf | endif
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
