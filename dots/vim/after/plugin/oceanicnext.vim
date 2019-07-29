let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1

"
" Highlight function
"

function! <sid>hi(group, fg, bg, attr, attrsp)
  " fg, bg, attr, attrsp
  if !empty(a:fg)
    exec "hi " . a:group . " guifg=" .  a:fg[0]
    exec "hi " . a:group . " ctermfg=" . a:fg[1]
  endif
  if !empty(a:bg)
    exec "hi " . a:group . " guibg=" .  a:bg[0]
    exec "hi " . a:group . " ctermbg=" . a:bg[1]
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" .   a:attr
    exec "hi " . a:group . " cterm=" . a:attr
  endif
  if !empty(a:attrsp)
    exec "hi " . a:group . " guisp=" . a:attrsp[0]
  endif
endfunction


"
" Customize some highlights
"

" Default colors
let s:base00=['#1b2b34', '235']
let s:base01=['#343d46', '237']
let s:base02=['#4f5b66', '240']
let s:base03=['#65737e', '243']
let s:base04=['#a7adba', '145']
let s:base05=['#c0c5ce', '251']
let s:base06=['#cdd3de', '252']
let s:base07=['#d8dee9', '253']
let s:base08=['#ec5f67', '203'] " red
let s:base09=['#f99157', '209'] " orange
let s:base0A=['#fac863', '221'] " yellow
let s:base0B=['#99c794', '114'] " green
let s:base0C=['#62b3b2', '73'] " cyan
let s:base0D=['#6699cc', '68'] " blue
let s:base0E=['#c594c5', '176'] " magenta
let s:base0F=['#ab7967', '137'] " brown
let s:base10=['#ffffff', '15'] " white
let s:none=['NONE', 'NONE']

" Custom colors
let s:bg=["#17252c", "235"]
let s:highlight = ['#1F3446', '235']
let s:search = ['#0F4767', '235']
let s:slightly_brighterer = ["#233843", "234"]
let s:error_red = ["#E83B45", "203"]
let s:diff_green = ["#637E6B", "114"]
let s:diff_red = ["#7F4B54", "203"]

function! s:ModifyColorscheme()
    " General
    call <sid>hi('Normal',      s:base05, s:none,   '',       '')
    call <sid>hi('IncSearch',   s:none,   s:search, 'NONE',   '')
    call <sid>hi('Search',      s:none,   s:search, 'NONE',   '')
    call <sid>hi('VertSplit',   s:base00, s:base00, 'NONE',   '')
    call <sid>hi('EndOfBuffer', s:none,   s:bg,     '',       '')
    call <sid>hi('CursorLine',  s:none,   s:base00, '',       '')
    call <sid>hi('ColorColumn', s:none,   s:base00, '',       '')
    call <sid>hi('NonText',     s:slightly_brighterer, s:none, '', '')
    call <sid>hi('Visual',      '',       s:base01, '',       '')
    call <sid>hi('SpellBad',    '',       '',       '',       s:base09)
    call <sid>hi('Folded',      s:base03, s:base00, 'italic', '')

    " Markdown
    call <sid>hi('mkdLink',      '',           '', 'underline', s:base0D)
    call <sid>hi('mkdInlineURL', '',           '', 'underline', s:base0D)
    call <sid>hi('mkdURL',       s:base0D,     '', 'underline', s:base0D)
    call <sid>hi('mkdCode',      s:base0E,     '', '',          '')
    call <sid>hi('mkdCodeDelimiter', s:base0E, '', '',          '')

    " coc.nvim
    call <sid>hi('CocHighlightText', '', s:highlight, '',     '')
    call <sid>hi("CocErrorFloat", s:error_red, s:none, '', '')
    call <sid>hi("CocErrorSign", s:error_red, s:none, '', '')
    call <sid>hi("CocErrorHighlight", '', s:none, 'undercurl', s:error_red)
    call <sid>hi("CocWarningFloat", s:base09, s:none, '', '')
    call <sid>hi("CocWarningSign", s:base09, s:none, '', '')
    call <sid>hi("CocWarningHighlight", '', s:none, 'undercurl', s:base09)
    call <sid>hi("CocInfoFloat", s:base0D, s:none, '', '')
    call <sid>hi("CocInfoSign", s:base0D, s:none, '', '')
    call <sid>hi("CocInfoHighlight", '', s:none, 'undercurl', s:base0D)

    " Customize NERDTree directory
    call <sid>hi('NERDTreeCWD', s:base0B, s:none, '', '')

    " tpope/vim-fugitive
    call <sid>hi('diffAdded', s:base0B, s:none, '', '')
    call <sid>hi('diffRemoved', s:base08, s:none, '', '')
endfunction

call s:ModifyColorscheme()

augroup ModifyColorscheme
    autocmd!
    autocmd ColorScheme * call s:ModifyColorscheme()
augroup END
