let s:deoplete_init_done=0
function! joosep#autocomplete#deoplete_init() abort
    if s:deoplete_init_done || !has('nvim')
        return
    endif
    let s:deoplete_init_done=1
    call deoplete#enable()
endfunction

