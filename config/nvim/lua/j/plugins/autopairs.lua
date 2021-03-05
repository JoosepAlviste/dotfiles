local autopairs = require('nvim-autopairs')

local map = require('j.utils').map

local M = {}

function _G.confirm()
  return autopairs.check_break_line_char()
end

function M.setup()
  autopairs.setup()

  map('i', '<cr>', [[v:lua.confirm()]], {expr = true, noremap = true})
end

return M
