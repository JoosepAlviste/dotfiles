"
" Highlight function
"

function! <sid>hi(group, fg, bg, attr, attrsp)
    call joosep#colors#hiSimple(a:group, a:fg, a:bg, a:attr, a:attrsp)
endfunction


"
" Customize some highlights
"

let s:colors = g:joosep#colors#palenight#GetColors()

" Default colors
let s:bg = s:colors.bg
let s:fg = s:colors.fg
let s:invisibles = s:colors.invisibles
let s:comments = s:colors.comments
let s:selection = s:colors.selection
let s:guides = s:colors.guides
let s:line_numbers = s:colors.line_numbers
let s:caret = s:colors.caret
let s:line_highlight = s:colors.line_highlight
let s:white = s:colors.white
let s:black = s:colors.black
let s:red = s:colors.red
let s:orange = s:colors.orange
let s:yellow = s:colors.yellow
let s:green = s:colors.green
let s:cyan = s:colors.cyan
let s:blue = s:colors.blue
let s:paleblue = s:colors.paleblue
let s:purple = s:colors.purple
let s:brown = s:colors.brown
let s:pink = s:colors.pink
let s:violet = s:colors.violet

" Custom colors
let s:background = s:colors.background
let s:statusline = s:colors.statusline
let s:cursorline = s:colors.cursorline
let s:darker_fg = s:colors.darker_fg

function! s:ModifyColorscheme()
    " " General
    call <sid>hi('Normal',       s:fg,         'NONE',         '',     '')
    call <sid>hi('IncSearch',    'NONE',       s:line_numbers, 'NONE', '')
    call <sid>hi('Search',       'NONE',       s:line_numbers, 'NONE', '')
    call <sid>hi('VertSplit',    s:bg,         s:background,   'NONE', '')
    call <sid>hi('CursorLine',   'NONE',       s:cursorline,   '',     '')
    call <sid>hi('CursorLineNr', s:darker_fg,  '',             '',     '')
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

    " reStructuredText
    call <sid>hi('rstInlineLiteral', s:darker_fg, '', '', '')
    call <sid>hi('rstLiteralBlock', s:darker_fg, '', '', '')
    call <sid>hi('rstInterpretedTextOrHyperlinkReference', s:blue, '', '', '')

    " HTML
    call <sid>hi('htmlLink',    s:blue,   '', 'underline', s:blue)
    call <sid>hi('htmlTagName', s:yellow, '', '',          '')
    call <sid>hi('htmlArg',     s:fg,     '', '',          '')
    call <sid>hi('htmlItalic',  s:blue,   '', 'italic',    '')
    call <sid>hi('htmlBold',    s:yellow, '', 'bold',    '')

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
endfunction

if g:colors_name ==# 'material'
    call s:ModifyColorscheme()

    augroup ModifyColorscheme
        autocmd!
        autocmd ColorScheme * call s:ModifyColorscheme()
    augroup END
endif
