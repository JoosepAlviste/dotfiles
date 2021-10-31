local map = require('j.utils').map

map('n', '<leader>oa', [[<cmd>lua require'harpoon.mark'.add_file()<cr>]])
map('n', '<leader>ot', [[<cmd>lua require'harpoon.ui'.toggle_quick_menu()<cr>]])

map('n', '<leader>oh', [[<cmd>lua require'harpoon.ui'.nav_file(1)<cr>]])
map('n', '<leader>on', [[<cmd>lua require'harpoon.ui'.nav_file(2)<cr>]])
map('n', '<leader>oe', [[<cmd>lua require'harpoon.ui'.nav_file(3)<cr>]])
map('n', '<leader>oi', [[<cmd>lua require'harpoon.ui'.nav_file(4)<cr>]])

map('n', '<leader>ol', [[<cmd>lua require'harpoon.term'.gotoTerminal(1)<cr>]])
map('n', '<leader>ou', [[<cmd>lua require'harpoon.term'.gotoTerminal(2)<cr>]])
