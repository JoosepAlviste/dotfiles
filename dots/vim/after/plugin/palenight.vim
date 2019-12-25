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
    call <sid>hi('Normal',       s:fg,         'none',         '',     '')
    call <sid>hi('IncSearch',    'none',       s:line_numbers, 'none', '')
    call <sid>hi('Search',       'none',       s:line_numbers, 'none', '')
    call <sid>hi('VertSplit',    s:bg,         s:background,   'none', '')
    call <sid>hi('CursorLine',   'none',       s:cursorline,   '',     '')
    call <sid>hi('CursorLineNr', s:darker_fg,  '',             '',     '')
    call <sid>hi('ColorColumn',  'none',       s:cursorline,   '',     '')
    call <sid>hi('Visual',       'none',       s:selection,    '',     '')
    call <sid>hi('SpellBad',     'none',       '',  'undercurl', s:orange)
    call <sid>hi('Folded',       s:comments,   s:bg,     'italic',     '')
    call <sid>hi('PMenu',        '',           s:bg,           '',     '')
    call <sid>hi('Include',      s:purple,     '',             '',     '')
    call <sid>hi('StatusLine',   s:fg,         s:statusline,   'none', '')
    call <sid>hi('StatusLineNC', s:darker_fg,  s:statusline,   'none', '')
    call <sid>hi('Noise',        s:cyan,       '',             '',     '')
    call <sid>hi('Todo',         s:orange,     'none',         '',     '')
    call <sid>hi('Title',        s:yellow,     '',             '',     '')
    call <sid>hi('LineNr',       s:invisibles, '',             '',     '')
    call <sid>hi('Comment',      '',           '',       'italic',     '')
    call <sid>hi('MatchParen',   'none',       s:invisibles,   '',     '')

    call <sid>hi('TabLine',      s:fg, s:statusline, 'none', '')
    call <sid>hi('TabLineFill',  s:fg, s:statusline, '',     '')
    call <sid>hi('TabLineSel',   s:cyan, s:bg,       '',     '')

    " Git
    call <sid>hi('DiffFile',    s:green,   'none', '', '')
    call <sid>hi('DiffNewFile', s:red, 'none', '', '')
    " Special tinted dark background colors for diff hunks
    call <sid>hi('DiffAdd',     'none',  '#22330A', 'none', '')
    call <sid>hi('DiffDelete',  'none',  '#3D000A', 'none', '')
    call <sid>hi('DiffChange',  'none',  '#002C3D', 'none', '')
    call <sid>hi('DiffText',    'none',  '#3D2800', 'none', '')

    " Markdown
    call <sid>hi('markdownCode',   s:darker_fg, '', '',       '')
    call <sid>hi('markdownItalic', s:blue,      '', 'italic', '')

    " reStructuredText
    call <sid>hi('rstInlineLiteral', s:darker_fg, '', '', '')
    call <sid>hi('rstLiteralBlock', s:darker_fg, '', '', '')
    call <sid>hi('rstInterpretedTextOrHyperlinkReference', s:blue, '', '', '')

    " HTML
    call <sid>hi('htmlLink',    s:blue,   '', 'underline', s:blue)
    call <sid>hi('htmlTagName', s:yellow, '', '',          '')
    call <sid>hi('htmlArg',     s:fg, '', '',          '')

    " Django
    call <sid>hi('djangoFilter', s:blue, '', '', '')

    " coc.nvim
    call <sid>hi('CocHighlightText', 'none', s:line_numbers, '',     '')
    call <sid>hi('CocErrorFloat', s:red, 'none', '', '')
    call <sid>hi('CocErrorSign', s:red, 'none', '', '')
    call <sid>hi('CocErrorHighlight', '', 'none', 'undercurl', s:red)
    call <sid>hi('CocWarningFloat', s:orange, 'none', '', '')
    call <sid>hi('CocWarningSign', s:orange, 'none', '', '')
    call <sid>hi('CocWarningHighlight', '', 'none', 'undercurl', s:orange)
    call <sid>hi('CocInfoFloat', s:cyan, 'none', '', '')
    call <sid>hi('CocInfoSign', s:cyan, 'none', '', '')
    call <sid>hi('CocInfoHighlight', '', 'none', 'undercurl', s:cyan)

    " NERDTree
    call <sid>hi('NERDTreeDirSlash', s:cyan, '', '', '')
    call <sid>hi('NERDTreeFlags', s:blue, '', '', '')

    " " tpope/vim-fugitive
    call <sid>hi('diffAdded',   s:green, 'none', 'none', '')
    call <sid>hi('diffRemoved', s:red,   'none', 'none', '')
    call <sid>hi('fugitiveHash', s:orange, '', '', '')

    " YATS
    call <sid>hi('typescriptMember', s:fg, '', '', '')
    call <sid>hi('typescriptAssign', s:purple, '', '', '')
    call <sid>hi('typescriptTypeAnnotation', s:purple, '', '', '')
    call <sid>hi('typescriptMemberOptionality', s:purple, '', '', '')
    call <sid>hi('typescriptVariable', s:purple, '', '', '')
    call <sid>hi('typescriptVariableDeclaration', s:blue, '', '', '')
    call <sid>hi('typescriptAliasDeclaration', s:yellow, '', '', '')
    call <sid>hi('typescriptTypeReference',    s:yellow, '', '', '')
    call <sid>hi('typescriptTypeBrackets', s:cyan, '', '', '')
    call <sid>hi('typescriptTypeBraces', s:cyan, '', '', '')
    call <sid>hi('typescriptArrowFunc', s:purple, '', '', '')

    call <sid>hi('tsxTagName', s:yellow, '', '', '')
    call <sid>hi('tsxIntrinsicTagName', s:yellow, '', '', '')
    call <sid>hi('tsxCloseString', s:cyan, '', '', '')
    call <sid>hi('tsxAttrib', s:fg, '', '', '')
    call <sid>hi('tsxEqual', s:purple, '', '', '')

    " JavaScript
    call <sid>hi('jsTemplateBraces', s:purple, '', '', '')
    call <sid>hi('jsTemplateExpression', 'none', '', '', '')
    call <sid>hi('jsNoise', s:cyan, '', '', '')
    call <sid>hi('jsFuncArgCommas', s:cyan, '', '', '')
    call <sid>hi('jsOperatorKeyword', s:purple, '', '', '')
    call <sid>hi('jsThis', s:purple, '', '', '')
    call <sid>hi('jsDocTypeBrackets', s:cyan, '', '', '')
    call <sid>hi('jsDocParam', s:yellow, '', '', '')
    call <sid>hi('jsDocTags', s:purple, '', '', '')

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
    call <sid>hi('semshiUnresolved',      'none',   '', 'undercurl', s:orange)
    call <sid>hi('semshiSelected',        'none',   s:line_numbers, '', '')

    sign define semshiError text=• texthl=CocErrorSign

    " Vimscript
    call <sid>hi('vimVar',      s:paleblue, '', '', '')
    call <sid>hi('vimFuncVar',  s:paleblue, '', '', '')
    call <sid>hi('vimFunction', s:blue,     '', '', '')

    " CSS
    call <sid>hi('cssTagName', s:blue, '', '', '')
    call <sid>hi('cssValueLength', s:green, '', '', '')

    " YAML
    call <sid>hi('yamlBlockMappingKey', s:blue, '', '', '')
    call <sid>hi('yamlKeyValueDelimiter', s:cyan, '', '', '')

    " JSON
    call <sid>hi('jsonQuote', s:cyan, '', '', '')
    call <sid>hi('jsonKeywordMatch', s:cyan, '', '', '')
    call <sid>hi('jsonBraces', s:cyan, '', '', '')

    " Shell
    call <sid>hi('shVariable', s:blue, '', '', '')

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
