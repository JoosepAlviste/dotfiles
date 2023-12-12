local M = {}

---@return boolean
function M.is_marketer_repo()
  return not not vim.loop.cwd():match '@modashio/marketer$'
end

return M
