local highlight = require('palenightfall.internal').highlight

local c = require('palenightfall').colors

require('palenightfall').setup({
  highlight_overrides = {
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
  },
})

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
