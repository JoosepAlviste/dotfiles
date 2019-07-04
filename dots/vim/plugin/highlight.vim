let s:group_colors = {} " Cache of default highlight group settings, for later reference via `nightowl_highlight`
function! s:h(group, style, ...)
  if (a:0 > 0) " Will be true if we got here from nightowl#extend_highlight
    let a:highlight = s:group_colors[a:group]
    for style_type in ["fg", "bg", "sp"]
      if (has_key(a:style, style_type))
        let l:default_style = (has_key(a:highlight, style_type) ? a:highlight[style_type] : { "cterm16": "NONE", "cterm": "NONE", "gui": "NONE" })
        let a:highlight[style_type] = extend(l:default_style, a:style[style_type])
      endif
    endfor
    if (has_key(a:style, "gui"))
      let a:highlight.gui = a:style.gui
    endif
  else
    let a:highlight = a:style
    let s:group_colors[a:group] = a:highlight " Cache default highlight group settings
  endif

  execute "highlight" a:group
    \ "guifg="   (has_key(a:highlight, "fg")    ? a:highlight.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:highlight, "bg")    ? a:highlight.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:highlight, "sp")    ? a:highlight.sp.gui   : "NONE")
    \ "gui="     (has_key(a:highlight, "gui")   ? a:highlight.gui      : "NONE")
    \ "ctermfg=" . "NONE"
    \ "ctermbg=" . "NONE"
    \ "cterm="   (has_key(a:highlight, "cterm") ? a:highlight.cterm    : "NONE")
endfunction


" Colors
let s:bg = { "gui": "#17252c", "cterm": "235", "cterm16": "0" }
let s:slightly_brighter = { "gui": "#1b2b34", "cterm": "234", "cterm16": "1" }

function! s:modify_highlights()
    " Make some backgrounds transparent
    hi! Normal ctermbg=NONE guibg=NONE
    hi! NonText ctermbg=NONE guibg=NONE
    hi! LineNr ctermbg=NONE guibg=NONE
    hi! CursorLineNr ctermbg=NONE guibg=NONE
    hi! SignColumn ctermfg=NONE guibg=NONE

    hi! GitGutterAdd ctermfg=NONE guibg=NONE
    hi! GitGutterChange ctermfg=NONE guibg=NONE
    hi! GitGutterRemove ctermfg=NONE guibg=NONE

    " Customize NERDTree directory
    hi! NERDTreeCWD guifg=#99c794

    call s:h("EndOfBuffer", { "bg": s:bg })
    call s:h("CursorLine", { "bg": s:slightly_brighter })
    call s:h("ColorColumn", { "bg": s:slightly_brighter })

    hi link jsonBraces Function
endfunction

call s:modify_highlights()

" Need to re-modify colorscheme after ColorScheme change (when reloading
" vimrc, for example)
augroup modify_colorscheme
    autocmd!
    autocmd ColorScheme * call s:modify_highlights()
augroup END
