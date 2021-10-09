local cmd = vim.cmd

local M = {}

function M.configure()
  cmd [[setlocal nonumber]]
  cmd [[setlocal norelativenumber]]
  cmd [[setlocal signcolumn=no]]

  cmd [[setlocal nottimeout]]
  cmd [[setlocal ttimeoutlen=10]]

  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<c-\><c-n>]], { noremap = true })
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<c-\><c-n>]], { noremap = true })
end

return M
