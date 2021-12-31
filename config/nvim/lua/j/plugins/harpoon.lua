local mark = require 'harpoon.mark'
local ui = require 'harpoon.ui'
local term = require 'harpoon.term'

local map = require('j.utils').map

map('n', '<leader>oa', mark.add_file)
map('n', '<leader>ot', ui.toggle_quick_menu)

map('n', '<leader>oh', function()
  ui.nav_file(1)
end)
map('n', '<leader>on', function()
  ui.nav_file(2)
end)
map('n', '<leader>oe', function()
  ui.nav_file(3)
end)
map('n', '<leader>oi', function()
  ui.nav_file(4)
end)

map('n', '<leader>ol', function()
  term.gotoTerminal(1)
end)
map('n', '<leader>ou', function()
  term.gotoTerminal(2)
end)
