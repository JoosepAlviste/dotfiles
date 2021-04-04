local map = require('j.utils').map

map('n', '<c-g>', [[<cmd>lua require('j.file_info.functions').file_info()<cr>]])
