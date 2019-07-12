function! s:ModifyHighlights()
    " Generic modifications to highlights -- not really related to a
    " colorscheme so they fit in their own file

    " Make some backgrounds transparent
    hi! Normal ctermbg=NONE guibg=NONE
    hi! NonText ctermbg=NONE guibg=NONE
    hi! LineNr ctermbg=NONE guibg=NONE
    hi! CursorLineNr ctermbg=NONE guibg=NONE
    hi! SignColumn ctermfg=NONE guibg=NONE

    hi! GitGutterAdd ctermfg=NONE guibg=NONE
    hi! GitGutterChange ctermfg=NONE guibg=NONE
    hi! GitGutterDelete ctermfg=NONE guibg=NONE
    hi! GitGutterChangeDelete ctermfg=NONE guibg=NONE

    hi link jsonBraces Function

    " Custom highlight group to dim inactive windows
    hi link MyInactiveWin ColorColumn
    hi link MyNormalWin Normal
endfunction

call s:ModifyHighlights()

" Need to re-modify highlights after ColorScheme change (when reloading
" vimrc, for example)
augroup ModifyHighlights
    autocmd!
    autocmd ColorScheme * call s:ModifyHighlights()
augroup END
