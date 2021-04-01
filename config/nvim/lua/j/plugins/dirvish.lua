local M = {}

function M.setup()
  -- Disable netrw
  vim.g.loaded_netrwPlugin = 1

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
end

return M
