local cmd = vim.cmd

local create_augroups = require('j.utils').create_augroups

local M = {}

local bg = '#292d3e'
local fg = '#a6accd'
local invisibles = '#4e5579'
local comments = '#676e95'
local selection = '#343A51'
local guides = '#4e5579'
local line_numbers = '#3a3f58'
local caret = '#ffcc00'
local line_highlight = '#000000'
local white = '#ffffff'
local black = '#000000'
local red = '#ff5370'
local orange = '#f78c6c'
local yellow = '#ffcb6b'
local green = '#c3e88d'
local cyan = '#89ddff'
local blue = '#82aaff'
local paleblue = '#b2ccd6'
local purple = '#c792ea'
local brown = '#c17e70'
local pink = '#f07178'
local violet = '#bb80b3'

-- Custom colors
local background = '#252837'  -- A bit darker background color
local statusline = '#1d1f2b'  -- Statusline should be dark
local cursorline = '#232534'  -- Cursorline should be a bit darker than bg
local darker_fg = '#7982B4'  -- Some text should be a bit darker than normal fg
local symbol_highlight = '#2B2F40'  -- Highlighting of the symbol under the cursor

local function hi(group, fg, bg, attr, attrsp)
  attr = attr or 'none'

  if fg then
    cmd(string.format('hi %s guifg=%s', group, fg))
  end

  if bg then
    cmd(string.format('hi %s guibg=%s', group, bg))
  end

  if attr then
    cmd(string.format('hi %s gui=%s cterm=%s', group, attr, attr))
  end

  if attrsp then
    cmd(string.format('hi %s guisp=%s', group, attrsp))
  end
end

function M.configure_colorscheme()
  -- General
  hi('Normal',       fg,             'NONE')
  hi('IncSearch',    'NONE',         line_numbers,    'NONE')
  hi('Search',       'NONE',         line_numbers,    'NONE')
  hi('VertSplit',    bg,             background,      'NONE')
  hi('CursorLine',   'NONE',         cursorline)
  hi('CursorLineNr', darker_fg)
  hi('Cursor',       'NONE',         blue)
  hi('iCursor',      'NONE',         blue)
  hi('ColorColumn',  'NONE',         cursorline)
  hi('Visual',       'NONE',         selection)
  hi('SpellBad',     'NONE',         nil,             'undercurl', orange)
  hi('Folded',       comments,       bg,              'italic')
  hi('FoldColumn',   invisibles,     background)
  hi('SignColumn',   invisibles,     background)
  hi('PMenu',        nil,            bg)
  hi('Include',      purple)
  hi('StatusLine',   fg,             statusline,      'NONE')
  hi('StatusLineNC', darker_fg,      statusline,      'NONE')
  hi('Noise',        cyan)
  hi('Todo',         orange,         'NONE')
  hi('Title',        yellow)
  hi('LineNr',       invisibles)
  hi('Comment',      nil,            nil,             'italic')
  hi('MatchParen',   'NONE',         line_numbers)
  hi('MatchWord',    'NONE',         symbol_highlight)
  hi('Identifier',   fg,             'NONE')
  hi('Conceal',      brown,          'NONE')
  hi('Delimiter',    cyan,           'NONE')
  hi('ErrorMsg',     red,            'NONE')
  hi('Error',        red,            'NONE')
  hi('TabLine',      fg,             statusline,      'NONE')
  hi('TabLineFill',  fg,             statusline)
  hi('TabLineSel',   cyan,           background)

  -- LSP
  hi('LspDiagnosticsDefaultError',         red,       'NONE')
  hi('LspDiagnosticsUnderlineError',       'NONE',    nil, 'undercurl', red)
  hi('LspDiagnosticsDefaultWarning',       orange,    'NONE')
  hi('LspDiagnosticsUnderlineWarning',     'NONE',    nil, 'undercurl', orange)
  hi('LspDiagnosticsDefaultInformation',   blue,      'NONE')
  hi('LspDiagnosticsUnderlineInformation', 'NONE',    nil, 'undercurl', blue)
  hi('LspDiagnosticsDefaultHint',          darker_fg, 'NONE')
  hi('LspDiagnosticsUnderlineHint',        comments,  nil, 'undercurl', comments)
  hi('LspReferenceText',                   nil,       line_numbers)
  hi('LspReferenceRead',                   nil,       line_numbers)
  hi('LspReferenceWrite',                  nil,       line_numbers)

  -- Git
  hi('gitcommitOverflow', red)
  hi('DiffFile',    green,   'NONE')
  hi('DiffNewFile', red, 'NONE')
  -- Special tinted dark background colors for diff hunks
  hi('DiffAdd',     'NONE',  '#1e3d27', 'NONE')
  hi('DiffDelete',  'NONE',  '#59222c', 'NONE')
  hi('DiffChange',  'NONE',  '#0a2e72', 'NONE')
  hi('DiffText',    'NONE',  '#0e43a5', 'NONE')

  -- Markdown
  hi('markdownCode',     darker_fg)
  hi('markdownItalic',   blue,      nil, 'italic')
  hi('markdownBold',     yellow,    nil, 'bold')
  hi('markdownUrl',      blue)
  hi('mkdHeading',       green)
  hi('mkdCode',          darker_fg)
  hi('mkdCodeDelimiter', darker_fg)
  hi('mkdCodeDelimiter', darker_fg)
  -- Fix weird linebreaks in LSP hover docs
  hi('mkdLineBreak',     background)

  -- HTML
  hi('htmlLink',    blue,   nil, 'underline', blue)
  hi('htmlTagName', yellow)
  hi('htmlArg',     fg)
  hi('htmlItalic',  blue,   nil, 'italic')
  hi('htmlBold',    yellow, nil, 'bold')

  -- Treesitter
  hi('TSConstructor',     yellow)
  hi('TSVariableBuiltin', orange)
  hi('TSConstBuiltin',    orange)
  hi('TSVariable',        fg)
  hi('TSKeywordOperator', purple)
  hi('TSTag',             yellow)
  hi('TSTagDelimiter',    darker_fg)

  -- tpope/vim-fugitive
  hi('diffAdded',    green, 'NONE', 'NONE')
  hi('diffRemoved',  red,   'NONE', 'NONE')
  hi('fugitiveHash', orange)

  -- YATS
  hi('typescriptMember',              fg)
  hi('typescriptAssign',              purple)
  hi('typescriptTypeAnnotation',      purple)
  hi('typescriptMemberOptionality',   purple)
  hi('typescriptVariableDeclaration', blue)
  hi('typescriptVariable',            purple)
  hi('typescriptDestructureVariable', fg)
  hi('typescriptIdentifier',          purple)
  hi('typescriptCall',                fg)
  hi('typescriptParens',              blue)
  hi('typescriptUnaryOp',             cyan)
  hi('typescriptArrowFuncArg',        fg)
  hi('typescriptDotNotation',         cyan)
  hi('typescriptFuncType',            fg)
  hi('typescriptDestructureComma',    cyan)
  hi('typescriptDestructureAs',       cyan)
  hi('typescriptObjectColon',         cyan)
  hi('typescriptDestructureLabel',    fg)
  hi('typescriptTemplateSB',          violet)
  hi('typescriptDefaultParam',        purple)
  hi('typescriptEnumKeyword',         purple)
  hi('typescriptOperator',            purple)
  hi('typescriptCastKeyword',         purple)
  hi('typescriptEnum',                yellow)
  hi('typescriptClassName',           yellow)
  hi('typescriptClassHeritage',       yellow)

  hi('typescriptDateMethod',    blue)
  hi('typescriptConsoleMethod', blue)
  hi('typescriptBOM',           fg)

  hi('tsxTagName',          yellow)
  hi('tsxIntrinsicTagName', yellow)
  hi('tsxCloseString',      cyan)
  hi('tsxAttrib',           fg)
  hi('tsxEqual',            purple)

  -- JavaScript with vim-js
  hi('jsTemplateBraces',        purple)
  hi('jsTemplateExpression',    'NONE')
  hi('jsNoise',                 cyan)
  hi('jsFuncArgCommas',         cyan)
  hi('jsOperatorKeyword',       purple)
  hi('jsThis',                  purple)
  hi('jsDocTypeBrackets',       cyan)
  hi('jsDocParam',              yellow)
  hi('jsDocTags',               purple, nil, 'italic')
  hi('jsImport',                purple)
  hi('jsModuleAs',              purple)
  hi('jsFrom',                  purple)
  hi('jsExport',                purple)
  hi('jsVariableType',          purple)
  hi('jsTry',                   purple)
  hi('jsCatch',                 purple)
  hi('jsFinally',               purple)
  hi('jsReturn',                purple)
  hi('jsObjectKey',             fg)
  hi('jsNewClassParens',        blue)
  hi('jsExceptionBraces',       blue)
  hi('jsObjectBraces',          blue)
  hi('jsAccessorBrackets',      blue)
  hi('jsFunctionBraces',        blue)
  hi('jsParens',                blue)
  hi('jsModuleBraces',          blue)
  hi('jsSwitchBraces',          blue)
  hi('jsDestructuringBrackets', blue)
  hi('jsDestructuringBraces',   blue)
  hi('jsClassBraces',           blue)
  hi('jsLoopBraces',            blue)
  hi('jsIfBraces',              blue)
  hi('jsBrackets',              blue)
  hi('jsBuiltinFunctions',      blue)
  hi('jsDocIdentifier',         comments)
  hi('jsDocTypeBlock',          comments)

  -- JSX
  hi('jsxTagName',          yellow)
  hi('jsxComponentName',    yellow)
  hi('jsxEndComponentName', yellow)
  hi('jsxEndString',        yellow)
  hi('jsxAttrib',           fg)

  -- Python
  hi('pythonDecorator', violet)
  hi('pythonDot', cyan)

  -- Vimscript
  hi('vimVar',      paleblue)
  hi('vimFuncVar',  paleblue)
  hi('vimFunction', blue)

  -- CSS
  hi('cssTagName',        orange)
  hi('cssValueLength',    green)
  hi('cssUIAttr',         fg)
  hi('cssFontAttr',       fg)
  hi('cssBackgroundAttr', fg)
  hi('cssBraces',         blue)
  hi('cssScssDefinition', yellow)

  -- SCSS
  hi('scssSelectorName', yellow)
  hi('scssVariable',     blue)
  hi('scssAttribute',    cyan)
  hi('sassAmpersand',    orange)

  -- YAML
  hi('yamlBlockMappingKey',   blue)
  hi('yamlKeyValueDelimiter', cyan)

  -- JSON
  hi('jsonQuote',        cyan)
  hi('jsonKeywordMatch', cyan)
  hi('jsonBraces',       cyan)

  -- Shell
  hi('shVariable', blue)

  -- LaTeX
  hi('texSection', purple)
  hi('texZone',    darker_fg)

  -- PHP
  hi('phpInclude', purple)
  hi('phpType',    purple)

  -- Git gutter signs
  hi('GitsignsAdd', green)
  hi('GitsignsChange', orange)
  hi('GitsignsDelete', red)

  -- nvim-web-devicons
  -- Create highlights for statusline
  local icons = require('nvim-web-devicons').get_icons()
  for _, icon_data in pairs(icons) do
    if icon_data.color and icon_data.name then
      local hl_group = icon_data.name and 'StatuslineDevIcon' .. icon_data.name
      if hl_group then
        hi(hl_group, icon_data.color, statusline)
      end
    end
  end

  -- Custom colors
  hi('StatuslineAccent',  cyan,   statusline)
  hi('StatuslineBoolean', orange, statusline)
  hi('StatuslineError',   red,    statusline)
  hi('StatuslineWarning', orange, statusline)
  hi('StatuslineSuccess', green,  statusline)
  hi('StatuslinePending', yellow, statusline)
end

function M.modify_highlights()
  -- Generic modifications to highlights -- not really related to a colorscheme

  -- Make some backgrounds transparent
  cmd [[ hi! Normal ctermbg=NONE guibg=NONE]]
  cmd [[ hi! NonText ctermbg=NONE guibg=NONE ]]
  cmd [[ hi! LineNr ctermbg=NONE guibg=NONE ]]
  cmd [[ hi! CursorLineNr ctermbg=NONE guibg=NONE ]]
  cmd [[ hi! SignColumn ctermfg=NONE guibg=NONE ]]

  cmd [[ hi! DiffAdd ctermfg=NONE guibg=NONE ]]
  cmd [[ hi! DiffChange ctermfg=NONE guibg=NONE ]]
  cmd [[ hi! DiffDelete ctermfg=NONE guibg=NONE ]]

  cmd [[ hi link jsonBraces Function ]]

  -- GraphQL
  cmd [[ hi link graphqlTemplateString Normal ]]
  cmd [[ hi link graphqlConstant Normal ]]
  cmd [[ hi link graphqlVariable Constant ]]
  cmd [[ hi link graphqlBraces Special ]]
  cmd [[ hi link graphqlOperator Special ]]
  cmd [[ hi link graphqlName Function ]]

  -- YATS
  cmd [[ hi link tsxIntrinsicTagName Identifier ]]
  cmd [[ hi link tsxTagName Identifier ]]
  cmd [[ hi link typescriptExport Include ]]
  cmd [[ hi link typescriptImport Include ]]
  cmd [[ hi link typescriptDefault Include ]]
  cmd [[ hi link typescriptSymbols Operator ]]
  cmd [[ hi link typescriptTypeReference Type ]]
  cmd [[ hi link typescriptTypeParameter Type ]]
  cmd [[ hi link typescriptAliasDeclaration Type ]]
  cmd [[ hi link typescriptObjectLabel Normal ]]
  cmd [[ hi link typescriptArrowFunc Keyword ]]
  cmd [[ hi link typescriptTypeBrackets Noise ]]
  cmd [[ hi link typescriptTypeBraces Noise ]]
  cmd [[ hi link typescriptBinaryOp Noise ]]
  cmd [[ hi link typescriptTernaryOp Noise ]]

  -- YAJS
  cmd [[ hi link javascriptArrowFunc Type ]]
  cmd [[ hi link javascriptOpSymbol Operator ]]

  -- JSX
  cmd [[ hi link jsxComponentName Identifier ]]

  -- vim-jsx-improve
  cmd [[ hi link jsStorageClass Identifier ]]
  cmd [[ hi link jsClassMethodType Keyword ]]
  cmd [[ hi link jsxTagName Identifier ]]
  cmd [[ hi link jsxEndComponentName Identifier ]]
  cmd [[ hi link jsxEndString Identifier ]]
  cmd [[ hi link jsFunction Keyword ]]
  cmd [[ hi link jsExportDefault Include ]]
  cmd [[ hi link jsLabel Conditional ]]

  -- Python
  cmd [[ hi link pythonInclude Include ]]
  cmd [[ hi link pythonStatement Keyword ]]

  -- Markdown
  cmd [[ hi link mkdBold htmlBold ]]
  cmd [[ hi link mkdItalic htmlItalic ]]

  -- YAML
  cmd [[ hi link yamlBool Boolean ]]
end

function M.setup()
  vim.o.termguicolors = true

  vim.g.material_terminal_italics = true
  vim.g.material_theme_style = 'palenight'

  create_augroups({
    colors = {
      {'ColorScheme', '*', [[lua require('j.plugins.material').configure_colorscheme()]]},
      {'ColorScheme', '*', [[lua require('j.plugins.material').modify_highlights()]]},
    },
  })

  cmd [[colorscheme material]]
end

return M
