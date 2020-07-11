"
" Customize the tender color theme.
"

" Default colors from tender theme
let s:red1 = '#f43753'
let s:red2 = '#c5152f'
let s:red3 = '#79313c'
let s:blue1 = '#b3deef'
let s:blue2 = '#73cef4'
let s:blue3 = '#44778d'
let s:blue4 = '#335261'
let s:blue5 = '#293b44'
let s:green1 = '#c9d05c'
let s:green2 = '#9faa00'
let s:green3 = '#6a6b3f'
let s:green4 = '#464632'
let s:yellow1 = '#d3b987'
let s:yellow2 = '#ffc24b'
let s:yellow3 = '#715b2f'
let s:highlighted = '#ffffff'
let s:text = '#eeeeee'
let s:pearl = '#dadada'
let s:gandalf = '#bbbbbb'
let s:grey1 = '#999999'
let s:grey2 = '#666666'
let s:grey3 = '#444444'
let s:shadow = '#323232'
let s:bg = '#282828'
let s:dark = '#202020'
let s:darker = '#1d1d1d'
let s:darkest = '#040404'

let s:colors = {
      \ "red1": s:red1,
      \ "red2": s:red2,
      \ "red3": s:red3,
      \ "blue1": s:blue1,
      \ "blue2": s:blue2,
      \ "blue3": s:blue3,
      \ "blue4": s:blue4,
      \ "blue5": s:blue5,
      \ "green1": s:green1,
      \ "green2": s:green2,
      \ "green3": s:green3,
      \ "green4": s:green4,
      \ "yellow1": s:yellow1,
      \ "yellow2": s:yellow2,
      \ "yellow3": s:yellow3,
      \ "highlighted": s:highlighted,
      \ "text": s:text,
      \ "pearl": s:pearl,
      \ "gandalf": s:gandalf,
      \ "grey1": s:grey1,
      \ "grey2": s:grey2,
      \ "grey3": s:grey3,
      \ "shadow": s:shadow,
      \ "bg": s:bg,
      \ "dark": s:dark,
      \ "darker": s:darker,
      \ "darkest": s:darkest,
      \ }


function! g:joosep#colors#tender#GetColors()
  return s:colors
endfunction


"
" Highlight function
"

function! <sid>hi(group, fg, bg, attr, attrsp)
  call joosep#colors#hiSimple(a:group, a:fg, a:bg, a:attr, a:attrsp)
endfunction


function! joosep#colors#tender#ModifyColorscheme()
  " General
  call <sid>hi('Normal',       s:text,    'NONE',  '',          '')
  call <sid>hi('StatusLine',   s:grey1,   s:dark,  'NONE',      '')
  call <sid>hi('StatusLineNC', s:grey2,   s:dark,  'NONE',      '')
  call <sid>hi('Todo',         s:yellow2, 'NONE',  '',          '')
  call <sid>hi('Comment',      '',        '',      'italic',    '')
  call <sid>hi('PMenu',        s:pearl,   s:grey3, '',          '')
  call <sid>hi('PMenuSbar',    s:grey3,   s:grey3, '',          '')
  call <sid>hi('SpellBad',     'NONE',    '',      'undercurl', s:yellow2)
  call <sid>hi('Search',       'NONE',    s:grey3, '',          '')
  call <sid>hi('IncSearch',    'NONE',    s:grey2, '',          '')
  call <sid>hi('Conceal',      s:yellow1, 'NONE',  '',          '')

  " JavaScript
  call <sid>hi('jsDocType', s:blue3, '', '', '')
  call <sid>hi('jsDocBraces', s:blue3, '', '', '')
  call <sid>hi('jsDocIdentifier', s:yellow3, '', '', '')
  call <sid>hi('jsDocTags', s:green3, '', '', '')

  " coc.nvim
  call <sid>hi('CocErrorFloat', s:red1, 'NONE', '', '')
  call <sid>hi('CocErrorSign', s:red1, 'NONE', '', '')
  call <sid>hi('CocErrorHighlight', '', 'NONE', 'undercurl', s:red1)
  call <sid>hi('CocWarningFloat', s:yellow2, 'NONE', '', '')
  call <sid>hi('CocWarningSign', s:yellow2, 'NONE', '', '')
  call <sid>hi('CocWarningHighlight', '', 'NONE', 'undercurl', s:yellow2)
  call <sid>hi('CocInfoFloat', s:blue2, 'NONE', '', '')
  call <sid>hi('CocInfoSign', s:blue2, 'NONE', '', '')
  call <sid>hi('CocInfoHighlight', '', 'NONE', 'undercurl', s:blue2)

  " Custom colors
  call <sid>hi('StatuslineAccent',  s:blue2,   s:dark, '', '')
  call <sid>hi('StatuslineBoolean', s:yellow1, s:dark, '', '')
  call <sid>hi('StatuslineError',   s:red2,    s:dark, '', '')
  call <sid>hi('StatuslineWarning', s:yellow2, s:dark, '', '')
  call <sid>hi('StatuslineSuccess', s:green2,  s:dark, '', '')
  call <sid>hi('StatuslinePending', s:yellow2, s:dark, '', '')
endfunction
