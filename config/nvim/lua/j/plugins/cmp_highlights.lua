local highlight = require('palenightfall.internal').highlight

local c = require('palenightfall').colors

local highlights = {
  CmpDocumentation = { bg = c.background_darker },
  CmpItemAbbrDefault = { fg = c.foreground },

  CmpItemAbbr = { fg = c.foreground },
  CmpItemAbbrDeprecated = { fg = c.foreground_darker, strikethrough = true },
  CmpItemAbbrMatch = { fg = c.blue },
  CmpItemAbbrMatchFuzzy = { fg = c.blue },

  CmpItemMenu = { fg = c.comments },

  CmpItemKindDefault = { fg = c.foreground_darker },

  CmpItemKindKeyword = { fg = c.purple },
  CmpItemKindReference = { fg = c.purple },
  CmpItemKindValue = { fg = c.purple },
  CmpItemKindVariable = { fg = c.purple },

  CmpItemKindConstant = { fg = c.orange },
  CmpItemKindEnum = { fg = c.orange },
  CmpItemKindEnumMember = { fg = c.orange },
  CmpItemKindOperator = { fg = c.orange },
  CmpItemKindField = { fg = c.orange },

  CmpItemKindFunction = { fg = c.blue },
  CmpItemKindMethod = { fg = c.blue },

  CmpItemKindConstructor = { fg = c.yellow },
  CmpItemKindClass = { fg = c.yellow },
  CmpItemKindInterface = { fg = c.yellow },
  CmpItemKindStruct = { fg = c.yellow },
  CmpItemKindEvent = { fg = c.yellow },
  CmpItemKindUnit = { fg = c.yellow },
  CmpItemKindFile = { fg = c.yellow },
  CmpItemKindFolder = { fg = c.yellow },

  CmpItemKindModule = { fg = c.green },
  CmpItemKindProperty = { fg = c.green },
  CmpItemKindTypeParameter = { fg = c.green },
  CmpItemKindSnippet = { fg = c.green },
  CmpItemKindText = { fg = c.green },
}

for group, colors in pairs(highlights) do
  highlight(group, colors)
end
