" "
" " Construct a custom statusline.
" "
" " Heavily inspired by the custom statusline from
" " https://github.com/rodrigore/Dotfiles.
" "
" 
" "
" " Colors used in the statusline
" "
" 
" let s:colors = g:joosep#colors#oceanicnext#GetColors()
" 
" let s:label_bg = s:colors.base02
" let s:value_bg = s:colors.base01
" let s:fg = s:colors.base07
" let s:none = s:colors.none
" 
" let s:normal = ['#91ddff', '68']  " neon cyan
" let s:insert = ['#95ffa4', '68']  " neon green
" let s:replace = s:colors.base08  " red
" let s:visual = ['#c991e1', '176']  " neon purple
" let s:command = ['#ffe9aa', '221']  " light yellow
" let s:error_red = s:colors.error_red
" 
" 
" "
" " Helper highlighting function to reduce typing
" "
" 
" function! <sid>hi(group, fg, bg, attr, attrsp)
"     call joosep#colors#hi(a:group, a:fg, a:bg, a:attr, a:attrsp)
" endfunction
" 
" 
" "
" " Statusline items and highlighting
" "
" 
" function! RedrawColors(mode)
"     " General colors
"     call <sid>hi('MyStatuslineLabelAccent', s:label_bg, s:none,     '', '')
"     call <sid>hi('MyStatuslineLabel',       s:fg,       s:label_bg, '', '')
"     call <sid>hi('MyStatuslineValueAccent', s:value_bg, s:none,     '', '')
"     call <sid>hi('MyStatuslineValue',       s:fg,       s:value_bg, '', '')
" 
"     call <sid>hi('MyStatuslineLineValue',     s:insert,  s:value_bg, '', '')
"     call <sid>hi('MyStatuslineFiletypeValue', s:visual,  s:value_bg, '', '')
"     call <sid>hi('MyStatuslineModifiedValue', s:replace, s:value_bg, '', '')
"     call <sid>hi('MyStatuslineReadonlyValue', s:replace, s:value_bg, '', '')
"     call <sid>hi('MyStatuslineTestStatus',    s:command, s:value_bg, '', '')
" 
"     " Mode-based colors
" 
"     if a:mode ==# 'n'
"         " Normal mode
"         call <sid>hi('MyStatuslineFilenameValue', s:normal, s:value_bg, '', '')
" 
"         call <sid>hi('MyStatuslineModeAccent', s:normal,   s:none,   '', '')
"         call <sid>hi('MyStatuslineModeValue',  s:value_bg, s:normal, '', '')
"     elseif a:mode ==# 'i'
"         " Insert mode
"         call <sid>hi('MyStatuslineFilenameValue', s:insert, s:value_bg, '', '')
" 
"         call <sid>hi('MyStatuslineModeAccent', s:insert,   s:none,   '', '')
"         call <sid>hi('MyStatuslineModeValue',  s:value_bg, s:insert, '', '')
"     elseif a:mode ==# 'R'
"         " Replace mode
"         call <sid>hi('MyStatuslineFilenameValue', s:replace, s:value_bg, '', '')
" 
"         call <sid>hi('MyStatuslineModeAccent', s:replace,  s:none,    '', '')
"         call <sid>hi('MyStatuslineModeValue',  s:value_bg, s:replace, '', '')
"     elseif a:mode ==# 'v' || a:mode ==# 'V' || a:mode ==# "\<C-v>"
"         " Visual mode
"         call <sid>hi('MyStatuslineFilenameValue', s:visual, s:value_bg, '', '')
" 
"         call <sid>hi('MyStatuslineModeAccent', s:visual,   s:none,   '', '')
"         call <sid>hi('MyStatuslineModeValue',  s:value_bg, s:visual, '', '')
"     elseif a:mode ==# 'c'
"         " Command mode
"         call <sid>hi('MyStatuslineFilenameValue', s:command, s:value_bg, '', '')
" 
"         call <sid>hi('MyStatuslineModeAccent', s:command,  s:none,    '', '')
"         call <sid>hi('MyStatuslineModeValue',  s:value_bg, s:command, '', '')
"     elseif a:mode ==# 't'
"         " Terminal mode
"         call <sid>hi('MyStatuslineFilenameValue', s:insert, s:value_bg, '', '')
" 
"         call <sid>hi('MyStatuslineModeAccent', s:insert,   s:none,   '', '')
"         call <sid>hi('MyStatuslineModeValue',  s:value_bg, s:insert, '', '')
"     endif
"     return ''
" endfunction
" 
" function! FormatMode(mode)
"     " Format mode information to show in the Mode indicator
"     if a:mode ==# 'n'
"         return 'NORMAL'
"     elseif a:mode ==# 'i'
"         return 'INSERT'
"     elseif a:mode ==# 'R'
"         return 'REPLACE'
"     elseif a:mode ==# 'v'
"         return 'VISUAL'
"     elseif a:mode ==# 'V'
"         return "V-LINE"
"     elseif a:mode ==# "\<C-v>"
"         return "V-BLOCK"
"     elseif a:mode ==# 'c'
"         return 'CMD'
"     elseif a:mode ==# 't'
"         return 'TERMINAL'
"     else
"         return 'NONE'
"     endif
" endfunction
" 
" function! ModifiedSymbol(modified)
"     if a:modified ==# 1
"         return "\u25CF"
"     else
"         return ''
"     endif
" endfunction
" 
" function! Filetype(filetype)
"     if a:filetype ==# ''
"         return '-'
"     else
"         return WebDevIconsGetFileTypeSymbol() . ' ' . a:filetype
"     endif
" endfunction
" 
" function! TestStatus() abort
"     if g:TestingStatus ==# 'passing'
"         call <sid>hi('MyStatuslineTestStatus', s:insert, s:value_bg, '', '')
"         return '  '
"     elseif g:TestingStatus ==# 'running'
"         return '  '
"     elseif g:TestingStatus ==# 'failing'
"         call <sid>hi('MyStatuslineTestStatus', s:error_red, s:value_bg, '', '')
"         return '  '
"     else
"         return ''
"     endif
" endfunction
" 
" function! LSDiagnostic()
"     let info = get(b:, 'coc_diagnostic_info', {})
" 
"     if get(info, 'error', 0)
"         return '  '
"     endif
" 
"     if get(info, 'warning', 0)
"         return info['warning'] . '  '
"     endif
" 
"     return '  '
" endfunction
" 
" 
" "
" " Construct the statusbar
" "
" 
" " The function RedrawColors will be called every time the mode changes, updating
" " the colors used for the components
" set statusline=%{RedrawColors(mode())}
" 
" 
" " Left side items
" 
" " Mode indicator
" set statusline+=%#MyStatuslineModeAccent#
" set statusline+=%#MyStatuslineModeValue#%{FormatMode(mode())}\ "
" " Filename
" set statusline+=%#MyStatuslineFilenameValue#\ %t
" set statusline+=%#MyStatuslineValueAccent#\ "
" " Modified symbol
" set statusline+=%#MyStatuslineValueAccent#%{&modified?'':''}
" set statusline+=%#MyStatuslineModifiedValue#%{ModifiedSymbol(&modified)}
" set statusline+=%#MyStatuslineValueAccent#%{&modified?'':''}
" " Readonly
" set statusline+=%#MyStatuslineValueAccent#%{&readonly?'':''}
" set statusline+=%#MyStatuslineReadonlyValue#%{&readonly?'':''}
" set statusline+=%#MyStatuslineValueAccent#%{&readonly?'':''}
" 
" 
" " Right side items
" 
" set statusline+=%=
" 
" set statusline+=%#MyStatuslineLabelAccent#%{strlen(coc#status())?'':''}
" set statusline+=%#MyStatuslineLabel#%{strlen(coc#status())?'LS\ ':''}
" set statusline+=%#MyStatuslineValue#%{strlen(coc#status())?'\ '.LSDiagnostic().'\ ':''}
" set statusline+=%#MyStatuslineValue#%{strlen(coc#status())?coc#status():''}
" set statusline+=%#MyStatuslineValueAccent#%{strlen(coc#status())?'\ ':''}
" 
" " Test status
" " set statusline+=%#MyStatuslineLabelAccent#%{g:TestingStatus!='waiting'?'':''}
" " set statusline+=%#MyStatuslineLabel#%{g:TestingStatus!='waiting'?'Tests\ ':''}
" " set statusline+=%#MyStatuslineTestStatus#%{g:TestingStatus!='waiting'?'\ '.TestStatus():''}
" " set statusline+=%#MyStatuslineValueAccent#%{g:TestingStatus!='waiting'?'\ ':''}
" " Line number in percentage
" set statusline+=%#MyStatuslineValueAccent#
" set statusline+=%#MyStatuslineLineValue#%p%%
" set statusline+=%#MyStatuslineValueAccent#\ "
" " Filetype
" set statusline+=%#MyStatuslineValueAccent#
" set statusline+=%#MyStatuslineFiletypeValue#%{Filetype(&filetype)}
" set statusline+=%#MyStatuslineValueAccent#\ "
