local autopairs = require 'nvim-autopairs'

local map = require('j.utils').map

local function confirm()
  return autopairs.check_break_line_char()
end

autopairs.setup {
  check_ts = true,
  enable_moveright = true,
}

map('i', '<cr>', confirm, { expr = true, noremap = true })
