local M = {}

function M.add_trailing_comma_if_needed()
  local line = vim.api.nvim_get_current_line()

  local should_add_comma = string.find(line, '[^,{[]$')
  if should_add_comma then
    return 'A,<cr>'
  else
    return 'o'
  end
end

return M
