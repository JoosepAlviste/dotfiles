let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

"
" Highlight function
"

function! <sid>hi(group, fg, bg, attr, attrsp)
    call joosep#colors#hi(a:group, a:fg, a:bg, a:attr, a:attrsp)
endfunction


"
" Customize some highlights
"

let s:colors = g:joosep#colors#oceanicnext#GetColors()

" Default colors
let s:base00=s:colors.base00
let s:base01=s:colors.base01
let s:base02=s:colors.base02
let s:base03=s:colors.base03
let s:base04=s:colors.base04
let s:base05=s:colors.base05
let s:base06=s:colors.base06
let s:base07=s:colors.base07
let s:base08=s:colors.base08 " red
let s:base09=s:colors.base09 " orange
let s:base0A=s:colors.base0A " yellow
let s:base0B=s:colors.base0B " green
let s:base0C=s:colors.base0C " cyan
let s:base0D=s:colors.base0D " blue
let s:base0E=s:colors.base0E " magenta
let s:base0F=s:colors.base0F " brown
let s:base10=s:colors.base10 " white
let s:none=s:colors.none

" Custom colors
let s:bg=s:colors.bg
let s:highlight = s:colors.highlight
let s:search = s:colors.search
let s:slightly_brighterer = s:colors.slightly_brighterer
let s:error_red = s:colors.error_red
let s:diff_green = s:colors.diff_green
let s:diff_red = s:colors.diff_red

let s:statusline = s:colors.statusline

function! s:ModifyColorscheme()
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
    call <sid>hi('StatusLine',   s:bg,     s:bg,     '',       '')
    call <sid>hi('StatusLineNC', s:bg,     s:bg,     '',       '')

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
endfunction

if g:colors_name ==# 'OceanicNext'
    call s:ModifyColorscheme()

    augroup ModifyColorscheme
        autocmd!
        autocmd ColorScheme * call s:ModifyColorscheme()
    augroup END
endif
