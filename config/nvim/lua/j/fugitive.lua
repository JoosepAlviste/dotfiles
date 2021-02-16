local map = require('j.utils').map

local M = {}

function M.setup()
  map('n', '<leader>gs', ':G<cr>', {silent = true})
end

return M
