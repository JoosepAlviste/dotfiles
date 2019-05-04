let s:focused = 0
function! joosep#interface#ToggleFocused()
    if s:focused == 0
        let s:focused = 1
        set laststatus=0
        set cmdheight=1
        set noruler
    else
        let s:focused = 0
        set laststatus=2
        set cmdheight=2
        set ruler
    endif
    set noshowmode
endfunction
