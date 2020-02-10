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
let s:bg=["#16242c", "235"]
let s:highlight = ['#1F3446', '235']
let s:search = ['#0F4767', '235']
let s:slightly_brighterer = ["#233843", "234"]
let s:error_red = ["#E83B45", "203"]
let s:diff_green = ["#637E6B", "114"]
let s:diff_red = ["#7F4B54", "203"]

let s:statusline = ["#131f26", "235"]

let s:colors = {
            \ "base00": s:base00,
            \ "base01": s:base01,
            \ "base02": s:base02,
            \ "base03": s:base03,
            \ "base04": s:base04,
            \ "base05": s:base05,
            \ "base06": s:base06,
            \ "base07": s:base07,
            \ "base08": s:base08,
            \ "base09": s:base09,
            \ "base0A": s:base0A,
            \ "base0B": s:base0B,
            \ "base0C": s:base0C,
            \ "base0D": s:base0D,
            \ "base0E": s:base0E,
            \ "base0F": s:base0F,
            \ "base10": s:base10,
            \ "none": s:none,
            \ "bg": s:bg,
            \ "highlight":  s:highlight,
            \ "search":  s:search,
            \ "slightly_brighterer":  s:slightly_brighterer,
            \ "error_red":  s:error_red,
            \ "diff_green":  s:diff_green,
            \ "diff_red":  s:diff_red,
            \ "statusline":  s:statusline,
            \ }


function! g:joosep#colors#oceanicnext#GetColors()
    return s:colors
endfunction



"
" Highlight function
"

function! <sid>hi(group, fg, bg, attr, attrsp)
    call joosep#colors#hi(a:group, a:fg, a:bg, a:attr, a:attrsp)
endfunction



"
" Modify highlights
"

function! joosep#colors#oceanicnext#ModifyColorscheme()
    " General
    call <sid>hi('Normal',       s:base05, s:none,   '',       '')
    call <sid>hi('IncSearch',    s:none,   s:search, 'NONE',   '')
    call <sid>hi('Search',       s:none,   s:search, 'NONE',   '')
    call <sid>hi('VertSplit',    s:base00, s:bg,     'NONE',   '')
    call <sid>hi('EndOfBuffer',  s:none,   s:bg,     '',       '')
    call <sid>hi('CursorLine',   s:none,   s:base00, '',       '')
    call <sid>hi('ColorColumn',  s:none,   s:base00, '',       '')
    call <sid>hi('NonText',      s:base03, s:none,   '',       '')
    call <sid>hi('Visual',       '',       s:slightly_brighterer, '', '')
    call <sid>hi('SpellBad',     '',       '',       '',       s:base09)
    call <sid>hi('Folded',       s:base03, s:base00, 'italic', '')
    call <sid>hi('PMenu',        '',       s:base00, '',       '')
    call <sid>hi('ErrorMsg',     s:error_red, s:none, '',      '')
    call <sid>hi('Include',      s:base0C, '',       '',       '')
    call <sid>hi('StatusLine',   s:statusline, s:base06, '',   '')
    call <sid>hi('StatusLineNC', s:statusline, s:base06, '',   '')
    call <sid>hi('Operator',     s:base0C, s:none,   '',       '')
    call <sid>hi('Noise',        s:base04, s:none,   '',       '')

    call <sid>hi('TabLine',      s:base04, s:statusline, 'NONE', '')
    call <sid>hi('TabLineFill',  s:base06, s:statusline, '', '')
    call <sid>hi('TabLineSel',   s:base0C, s:bg,         '', '')

    " Git
    call <sid>hi('DiffFile',    s:base08, s:none, '', '')
    call <sid>hi('DiffNewFile', s:base0B, s:none, '', '')
    call <sid>hi('DiffLine',    s:base0D, s:none, '', '')

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

    " NERDTree
    call <sid>hi('NERDTreeCWD', s:base0B, s:none, '', '')

    " tpope/vim-fugitive
    call <sid>hi('diffAdded', s:base0B, s:none, '', '')
    call <sid>hi('diffRemoved', s:base08, s:none, '', '')

    " Python
    call <sid>hi('pythonDecorator', s:base0D, '', '', '')
    call <sid>hi('pythonDecoratorName', s:base0D, '', '', '')

    " numirias/semshi
    call <sid>hi('semshiLocal',           s:base0A, '', 'NONE',      '')
    call <sid>hi('semshiGlobal',          s:base0A, '', 'NONE',      '')
    call <sid>hi('semshiImported',        s:base0A, '', 'NONE',      '')
    call <sid>hi('semshiParameter',       s:base0D, '', 'NONE',      '')
    call <sid>hi('semshiParameterUnused', s:base03, '', 'undercurl', '')
    " call <sid>hi('semshiFree            ctermfg=218 guifg=#ffafd7')
    call <sid>hi('semshiBuiltin',         s:base0E, '', '', '')
    call <sid>hi('semshiAttribute',       s:base0C, '', '', '')
    call <sid>hi('semshiSelf',            s:base0E, '', '', '')
    call <sid>hi('semshiUnresolved',      s:none,   '', 'undercurl', s:base09)
    call <sid>hi('semshiSelected',        s:none,   s:highlight, '', '')

    sign define semshiError text=• texthl=CocErrorSign

    " Custom colors
    call <sid>hi('StatuslineAccent',    s:base0C,    s:statusline, '', '')
    call <sid>hi('StatuslineBoolean',   s:base09,    s:statusline, '', '')
    call <sid>hi('StatuslineError',     s:error_red, s:statusline, '', '')
    call <sid>hi('StatuslineWarning',   s:base09,    s:statusline, '', '')
endfunction
