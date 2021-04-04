local autopairs = require('nvim-autopairs')

local map = require('j.utils').map

function _G.confirm()
  return autopairs.check_break_line_char()
end

autopairs.setup({
  check_line_pair = false,
})

map('i', '<cr>', [[v:lua.confirm()]], {expr = true, noremap = true})
