"
" Customize the Material color theme.
"

" Copy colors to local variables so that it's easier to use them
let s:bg = '#292d3e'
let s:fg = '#a6accd'
let s:invisibles = '#4e5579'
let s:comments = '#676e95'
let s:selection = '#343A51'
let s:guides = '#4e5579'
let s:line_numbers = '#3a3f58'
let s:caret = '#ffcc00'
let s:line_highlight = '#000000'
let s:white = '#ffffff'
let s:black = '#000000'
let s:red = '#ff5370'
let s:orange = '#f78c6c'
let s:yellow = '#ffcb6b'
let s:green = '#c3e88d'
let s:cyan = '#89ddff'
let s:blue = '#82aaff'
let s:paleblue = '#b2ccd6'
let s:purple = '#c792ea'
let s:brown = '#c17e70'
let s:pink = '#f07178'
let s:violet = '#bb80b3'

" Custom colors (defaults)
let s:background = '#252837'  " A bit darker background color
let s:statusline = '#1d1f2b'  " Statusline should be dark
let s:cursorline = '#232534'  " Cursorline should be a bit darker than bg
let s:darker_fg = '#7982B4'  " Some text should be a bit darker than normal fg

if g:material_theme_style == 'palenight'
  " Custom colors
  let s:background = '#252837'  " A bit darker background color
  let s:statusline = '#1d1f2b'  " Statusline should be dark
  let s:cursorline = '#232534'  " Cursorline should be a bit darker than bg
  let s:darker_fg = '#7982B4'  " Some text should be a bit darker than normal fg
endif

let s:colors = {
      \ "bg": s:bg,
      \ "fg": s:fg,
      \ "invisibles": s:invisibles,
      \ "comments": s:comments,
      \ "selection": s:selection,
      \ "guides": s:guides,
      \ "line_numbers": s:line_numbers,
      \ "caret": s:caret,
      \ "line_highlight": s:line_highlight,
      \ "white": s:white,
      \ "black": s:black,
      \ "red": s:red,
      \ "orange": s:orange,
      \ "yellow": s:yellow,
      \ "green": s:green,
      \ "cyan": s:cyan,
      \ "blue": s:blue,
      \ "paleblue": s:paleblue,
      \ "purple": s:purple,
      \ "brown": s:brown,
      \ "pink": s:pink,
      \ "violet": s:violet,
      \ "background": s:background,
      \ "statusline": s:statusline,
      \ "cursorline": s:cursorline,
      \ "darker_fg": s:darker_fg,
      \ }

function! g:joosep#colors#material#GetColors()
    return s:colors
endfunction



"
" Highlight function
"

function! <sid>hi(group, fg, bg, attr, attrsp)
    call joosep#colors#hiSimple(a:group, a:fg, a:bg, a:attr, a:attrsp)
endfunction



"
" Modify the Material colors
"

function! joosep#colors#material#ModifyColorscheme()
  " General
  call <sid>hi('Normal',       s:fg,         'NONE',         '',     '')
  call <sid>hi('IncSearch',    'NONE',       s:line_numbers, 'NONE', '')
  call <sid>hi('Search',       'NONE',       s:line_numbers, 'NONE', '')
  call <sid>hi('VertSplit',    s:bg,         s:background,   'NONE', '')
  call <sid>hi('CursorLine',   'NONE',       s:cursorline,   '',     '')
  call <sid>hi('CursorLineNr', s:darker_fg,  '',             '',     '')
  call <sid>hi('Cursor',       'NONE',       s:blue,         '',     '')
  call <sid>hi('iCursor',      'NONE',       s:blue,         '',     '')
  call <sid>hi('ColorColumn',  'NONE',       s:cursorline,   '',     '')
  call <sid>hi('Visual',       'NONE',       s:selection,    '',     '')
  call <sid>hi('SpellBad',     'NONE',       '',  'undercurl', s:orange)
  call <sid>hi('Folded',       s:comments,   s:bg,     'italic',     '')
  call <sid>hi('FoldColumn',   s:invisibles, s:background,   '',     '')
  call <sid>hi('PMenu',        '',           s:bg,           '',     '')
  call <sid>hi('Include',      s:purple,     '',             '',     '')
  call <sid>hi('StatusLine',   s:fg,         s:statusline,   'NONE', '')
  call <sid>hi('StatusLineNC', s:darker_fg,  s:statusline,   'NONE', '')
  call <sid>hi('Noise',        s:cyan,       '',             '',     '')
  call <sid>hi('Todo',         s:orange,     'NONE',         '',     '')
  call <sid>hi('Title',        s:yellow,     '',             '',     '')
  call <sid>hi('LineNr',       s:invisibles, '',             '',     '')
  call <sid>hi('Comment',      '',           '',       'italic',     '')
  call <sid>hi('MatchParen',   'NONE',       s:invisibles,   '',     '')
  call <sid>hi('Identifier',   s:purple,     'NONE',         '',     '')
  call <sid>hi('Conceal',      s:brown,      'NONE',         '',     '')

  call <sid>hi('TabLine',      s:fg, s:statusline, 'NONE', '')
  call <sid>hi('TabLineFill',  s:fg, s:statusline, '',     '')
  call <sid>hi('TabLineSel',   s:cyan, s:bg,       '',     '')

  " Git
  call <sid>hi('gitcommitOverflow', s:red, '', '', '')
  call <sid>hi('DiffFile',    s:green,   'NONE', '', '')
  call <sid>hi('DiffNewFile', s:red, 'NONE', '', '')
  " Special tinted dark background colors for diff hunks
  call <sid>hi('DiffAdd',     'NONE',  '#1e3d27', 'NONE', '')
  call <sid>hi('DiffDelete',  'NONE',  '#59222c', 'NONE', '')
  call <sid>hi('DiffChange',  'NONE',  '#0a2e72', 'NONE', '')
  call <sid>hi('DiffText',    'NONE',  '#0e43a5', 'NONE', '')

  " Markdown
  call <sid>hi('markdownCode',     s:darker_fg, '', '',       '')
  call <sid>hi('markdownItalic',   s:blue,      '', 'italic', '')
  call <sid>hi('mkdHeading',       s:green,     '', '',       '')
  call <sid>hi('mkdCode',          s:darker_fg, '', '',       '')
  call <sid>hi('mkdCodeDelimiter', s:darker_fg, '', '',       '')
  call <sid>hi('mkdCodeDelimiter', s:darker_fg, '', '',       '')

  " reStructuredText
  call <sid>hi('rstInlineLiteral', s:darker_fg, '', '', '')
  call <sid>hi('rstLiteralBlock', s:darker_fg, '', '', '')
  call <sid>hi('rstInterpretedTextOrHyperlinkReference', s:blue, '', '', '')

  " HTML
  call <sid>hi('htmlLink',    s:blue,   '', 'underline', s:blue)
  call <sid>hi('htmlTagName', s:yellow, '', '',          '')
  call <sid>hi('htmlArg',     s:fg,     '', '',          '')
  call <sid>hi('htmlItalic',  s:blue,   '', 'italic',    '')
  call <sid>hi('htmlBold',    s:yellow, '', 'bold',      '')

  " Django
  call <sid>hi('djangoFilter', s:blue, '', '', '')

  " coc.nvim
  call <sid>hi('CocHighlightText', 'NONE', s:line_numbers, '',     '')
  call <sid>hi('CocErrorFloat', s:red, 'NONE', '', '')
  call <sid>hi('CocErrorSign', s:red, 'NONE', '', '')
  call <sid>hi('CocErrorHighlight', '', 'NONE', 'undercurl', s:red)
  call <sid>hi('CocWarningFloat', s:orange, 'NONE', '', '')
  call <sid>hi('CocWarningSign', s:orange, 'NONE', '', '')
  call <sid>hi('CocWarningHighlight', '', 'NONE', 'undercurl', s:orange)
  call <sid>hi('CocInfoFloat', s:cyan, 'NONE', '', '')
  call <sid>hi('CocInfoSign', s:cyan, 'NONE', '', '')
  call <sid>hi('CocInfoHighlight', '', 'NONE', 'undercurl', s:cyan)

  " NERDTree
  call <sid>hi('NERDTreeDirSlash', s:cyan, '', '', '')
  call <sid>hi('NERDTreeFlags', s:blue, '', '', '')

  " " tpope/vim-fugitive
  call <sid>hi('diffAdded',   s:green, 'NONE', 'NONE', '')
  call <sid>hi('diffRemoved', s:red,   'NONE', 'NONE', '')
  call <sid>hi('fugitiveHash', s:orange, '', '', '')

  " YATS
  call <sid>hi('typescriptMember', s:fg, '', '', '')
  call <sid>hi('typescriptAssign', s:purple, '', '', '')
  call <sid>hi('typescriptTypeAnnotation', s:purple, '', '', '')
  call <sid>hi('typescriptMemberOptionality', s:purple, '', '', '')
  call <sid>hi('typescriptVariableDeclaration', s:blue, '', '', '')

  call <sid>hi('tsxTagName', s:yellow, '', '', '')
  call <sid>hi('tsxIntrinsicTagName', s:yellow, '', '', '')
  call <sid>hi('tsxCloseString', s:cyan, '', '', '')
  call <sid>hi('tsxAttrib', s:fg, '', '', '')
  call <sid>hi('tsxEqual', s:purple, '', '', '')

  " JavaScript
  call <sid>hi('jsTemplateBraces', s:purple, '', '', '')
  call <sid>hi('jsTemplateExpression', 'NONE', '', '', '')
  call <sid>hi('jsNoise', s:cyan, '', '', '')
  call <sid>hi('jsFuncArgCommas', s:cyan, '', '', '')
  call <sid>hi('jsOperatorKeyword', s:purple, '', '', '')
  call <sid>hi('jsThis', s:purple, '', '', '')
  call <sid>hi('jsDocTypeBrackets', s:cyan, '', '', '')
  call <sid>hi('jsDocParam', s:yellow, '', '', '')
  call <sid>hi('jsDocTags', s:purple, '', 'italic', '')

  " JSX
  call <sid>hi('jsxTagName', s:yellow, '', '', '')
  call <sid>hi('jsxComponentName', s:yellow, '', '', '')
  call <sid>hi('jsxEndComponentName', s:yellow, '', '', '')
  call <sid>hi('jsxEndString', s:yellow, '', '', '')
  call <sid>hi('jsxAttrib', s:fg, '', '', '')

  " Python
  call <sid>hi('pythonDecorator', s:violet, '', '', '')
  call <sid>hi('pythonDot', s:cyan, '', '', '')

  " numirias/semshi
  call <sid>hi('semshiLocal',           s:yellow, '', 'NONE',      '')
  call <sid>hi('semshiGlobal',          s:yellow, '', 'NONE',      '')
  call <sid>hi('semshiImported',        s:yellow, '', 'NONE',      '')
  call <sid>hi('semshiParameter',       s:blue, '', 'NONE',      '')
  call <sid>hi('semshiParameterUnused', s:darker_fg, '', 'undercurl', '')
  call <sid>hi('semshiBuiltin',         s:purple, '', '', '')
  call <sid>hi('semshiAttribute',       s:cyan, '', '', '')
  call <sid>hi('semshiSelf',            s:purple, '', '', '')
  call <sid>hi('semshiUnresolved',      'NONE',   '', 'undercurl', s:orange)
  call <sid>hi('semshiSelected',        'NONE',   s:line_numbers, '', '')

  sign define semshiError text=• texthl=CocErrorSign

  " Vimscript
  call <sid>hi('vimVar',      s:paleblue, '', '', '')
  call <sid>hi('vimFuncVar',  s:paleblue, '', '', '')
  call <sid>hi('vimFunction', s:blue,     '', '', '')

  " CSS
  call <sid>hi('cssTagName', s:blue, '', '', '')
  call <sid>hi('cssValueLength', s:green, '', '', '')

  " SCSS
  call <sid>hi('scssSelectorName', s:yellow, '', '', '')
  call <sid>hi('scssVariable', s:blue, '', '', '')

  " YAML
  call <sid>hi('yamlBlockMappingKey', s:blue, '', '', '')
  call <sid>hi('yamlKeyValueDelimiter', s:cyan, '', '', '')

  " JSON
  call <sid>hi('jsonQuote', s:cyan, '', '', '')
  call <sid>hi('jsonKeywordMatch', s:cyan, '', '', '')
  call <sid>hi('jsonBraces', s:cyan, '', '', '')

  " Shell
  call <sid>hi('shVariable', s:blue, '', '', '')

  " LaTeX
  call <sid>hi('texSection', s:purple, '', '', '')
  call <sid>hi('texZone', s:darker_fg, '', '', '')

  " Custom colors
  call <sid>hi('StatuslineAccent',  s:cyan,   s:statusline, '', '')
  call <sid>hi('StatuslineBoolean', s:orange, s:statusline, '', '')
  call <sid>hi('StatuslineError',   s:red,    s:statusline, '', '')
  call <sid>hi('StatuslineWarning', s:orange, s:statusline, '', '')
  call <sid>hi('StatuslineSuccess', s:green,  s:statusline, '', '')
  call <sid>hi('StatuslinePending', s:yellow, s:statusline, '', '')
endfunction