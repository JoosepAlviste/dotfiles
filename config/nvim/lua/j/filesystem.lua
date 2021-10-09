local M = {}

function M.open_special_file()
  vim.fn.system('open ' .. vim.fn.expand '%:p')
  vim.cmd [[buffer#]]
  vim.cmd [[bdelete#]]
  vim.cmd [[redraw!]]
end

return M
