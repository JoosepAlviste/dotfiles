local map = require('j.utils').map

local M = {}

function M.setup()
  -- Sort directories first
  vim.g.dirvish_mode = ':sort ,^.*[\\/], '
  -- Ignore turds left behind by macOS, Git, and a few other things
  vim.g.dirvish_hidden_files = {
    'tags',
    '\\.git\\/',
    '\\.DS_Store',
    '\\.localized',
  }

  vim.g.dirvish_mode = vim.g.dirvish_mode .. '| silent keeppatterns g/\\v\\/(' .. table.concat(vim.g.dirvish_hidden_files, '|') .. ')/d _'

  map('n', '<c-n>', ':leftabove 40vsplit | silent Dirvish<cr>')
end

return M
