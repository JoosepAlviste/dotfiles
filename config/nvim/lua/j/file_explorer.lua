vim.g.netrw_banner = false
vim.g.netrw_list_hide = '^\\./$,^\\.\\./$'
vim.g.netrw_hide = 1

local M = {}

function M.open_parent_dir()
  local current_file = vim.fn.expand '%'
  local current_netrw_folder = vim.b.netrw_curdir

  local current_file_path = current_file == '' and current_netrw_folder or current_file
  local basename = vim.fn.fnamemodify(current_file_path, ':t')

  vim.cmd.e(vim.fn.fnamemodify(current_file_path, ':h'))

  vim.fn.search(string.format('^%s.$', basename))
end

return M
