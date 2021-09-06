local function highlight(group, colors)
  local style = colors.style and 'gui=' .. colors.style or 'gui=NONE'
  local fg = colors.fg and 'guifg=' .. colors.fg or 'guifg=NONE'
  local bg = colors.bg and 'guibg=' .. colors.bg or 'guibg=NONE'
  local sp = colors.sp and 'guisp=' .. colors.sp or ''

  vim.cmd(string.format('highlight %s %s %s %s %s', group, style, fg, bg, sp))
end

-- Link the first highlight group to the second one
local function link(a, b)
  vim.cmd(string.format('highlight default link %s %s', a, b))
end

-- All colors of the theme
local colors = {
  background = '#252837',
  foreground = '#a6accd',

  background_darker = '#232534',
  highlight = '#2b2f40',
  selection = '#343A51',
  statusline = '#1d1f2b',
  foreground_darker = '#7982b4',
  line_numbers = '#4e5579',
  comments = '#676e95',

  red = '#ff5370',
  orange = '#f78c6c',
  yellow = '#ffcb6b',
  green = '#c3e88d',
  cyan = '#89ddff',
  blue = '#82aaff',
  paleblue = '#b2ccd6',
  purple = '#D49BFD',
  brown = '#c17e70',
  pink = '#f07178',
  violet = '#bb80b3',
}

local c = colors

local groups = {
  -- UI elements
  LineNr       = { fg = c.line_numbers },
  CursorLine   = { bg = c.background_darker },
  CursorLineNr = { fg = c.foreground_darker },
  ColorColumn  = { bg = c.background_darker },
  Search       = { bg = c.highlight },
  IncSearch    = { bg = c.highlight },
  Visual       = { bg = c.selection },
  MatchParen   = { bg = c.line_numbers },
  SignColumn   = { bg = 'NONE' },
  VertSplit    = { fg = c.highlight, bg = c.background },
  Statusline   = { fg = c.foreground, bg = c.statusline },
  StatuslineNC = { fg = c.foreground_darker, bg = c.statusline },
  PMenu        = { bg = c.background_darker },
  PMenuSBar    = { bg = c.background_darker },
  PMenuThumb   = { bg = c.background },
  PMenuSel     = { fg = c.cyan, bg = c.background },

  -- Syntax
  Normal      = { fg = c.foreground },
  Identifier  = { fg = c.foreground },
  Comment     = { fg = c.comments, style = 'italic' },
  NonText     = { fg = c.comments },
  Keyword     = { fg = c.purple },
  Repeat      = { fg = c.purple },
  Conditional = { fg = c.purple },
  Statement   = { fg = c.purple },
  Include     = { fg = c.purple },
  Function    = { fg = c.blue },
  String      = { fg = c.green },
  Delimiter   = { fg = c.cyan },
  Operator    = { fg = c.cyan },
  PreProc     = { fg = c.cyan },
  Special     = { fg = c.violet },
  Constant    = { fg = c.orange },
  Todo        = { fg = c.orange },
  Title       = { fg = c.yellow },
  Type        = { fg = c.yellow },
  SpellBad    = { style = 'undercurl', sp = c.orange },

  -- LSP
  LspDiagnosticsDefaultError       = { fg = c.red },
  LspDiagnosticsUnderlineError     = { fg = 'NONE', style = 'undercurl', sp = c.red },
  LspDiagnosticsDefaultWarning     = { fg = c.orange },
  LspDiagnosticsUnderlineWarning   = { fg = 'NONE', style = 'undercurl', sp = c.orange },
  LspDiagnosticsDefaultInformation = { fg = c.blue },
  LspDiagnosticsUnderlineInformation = { fg = 'NONE', style = 'undercurl', sp = c.blue },
  LspDiagnosticsDefaultHint        = { fg = c.darker_fg },
  LspDiagnosticsUnderlineHint      = { fg = c.comments, style = 'undercurl', sp = c.comments },
  LspReferenceText                 = { bg = c.line_numbers },
  LspReferenceRead                 = { bg = c.line_numbers },
  LspReferenceWrite                = { bg = c.line_numbers },
  LspDiagnosticsLineNrError        = { fg = c.red, bg = '#312a34', style = 'bold' },
  LspDiagnosticsLineNrWarning      = { fg = c.orange, bg = '#312e3a', style = 'bold' },
  LspDiagnosticsVirtualTextError   = { fg = '#9e4057' },
  LspDiagnosticsVirtualTextWarning = { fg = '#9a6054' },

  -- Treesitter
  TSConstructor = { fg = c.yellow },
  TSTag         = { fg = c.yellow },
  TSTagDelimiter = { fg = c.foreground_darker },

  -- Custom colors
  StatuslineAccent  = { fg = c.cyan,   bg = c.statusline },
  StatuslineBoolean = { fg = c.orange, bg = c.statusline },
  StatuslineError   = { fg = c.red,    bg = c.statusline },
  StatuslineWarning = { fg = c.orange, bg = c.statusline },
  StatuslineSuccess = { fg = c.green,  bg = c.statusline },
  StatuslinePending = { fg = c.yellow, bg = c.statusline },
  StatuslineNormal  = { fg = c.cyan,   bg = c.statusline },
  StatuslineInsert  = { fg = c.green,  bg = c.statusline },
  StatuslineReplace = { fg = c.orange, bg = c.statusline },
  StatuslineVisual  = { fg = c.purple, bg = c.statusline },
  StatuslineCommand = { fg = c.yellow, bg = c.statusline },

  -- Markdown
  mkdHeading       = { fg = c.green },
  mkdListItem      = { fg = c.cyan },
  mkdCode          = { fg = c.foreground_darker },

  -- lewis6991/gitsigns.nvim
  GitSignsAdd    = { fg = c.green },
  GitSignsChange = { fg = c.orange },
  GitSignsDelete = { fg = c.red },
}

local function init()
  link('TSKeywordOperator', 'Keyword')
  link('TSConstBuiltin', 'Constant')
  link('TSFuncBuiltin', 'Function')
  link('TSVariableBuiltin', 'Identifier')

  link('mkdCodeDelimiter', 'mkdCode')

  for group, highlights in pairs(groups) do
    highlight(group, highlights)
  end

  -- nvim-web-devicons
  -- Create highlights for statusline
  local icons = require('nvim-web-devicons').get_icons()
  for _, icon_data in pairs(icons) do
    if icon_data.color and icon_data.name then
      local hl_group = icon_data.name and 'StatuslineDevIcon' .. icon_data.name
      if hl_group then
        highlight(hl_group, { fg = icon_data.color, bg = c.statusline })
      end
    end
  end
end

init()
