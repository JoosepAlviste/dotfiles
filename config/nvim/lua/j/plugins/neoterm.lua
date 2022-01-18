local map = require('j.utils').map

local M = {}

function M.setup()
  vim.g.neoterm_default_mod = 'botright'
  vim.g.neoterm_size = 12
  vim.g.neoterm_autoinsert = 1
  vim.g.neoterm_shell = '/bin/zsh'

  map('n', '<c-q>', [[:Ttoggle<cr>]], {silent = true})
  map('t', '<c-q>', [[<c-\><c-n>:Ttoggle<cr>]], {silent = true})
end

return M
