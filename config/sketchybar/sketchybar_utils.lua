local M = {}

---@param n number
function M.sleep(n)
  os.execute('sleep ' .. tonumber(n))
end

---Split a text by some character into a table.
---@param inputstr string
---@param sep string
---@return string[]
function M.split(inputstr, sep)
  if sep == nil then
    sep = '%s'
  end
  local t = {}
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do
    table.insert(t, str)
  end
  return t
end

---@generic T
---@param callback fun(item: T): boolean
---@param tbl T[]
---@return T[]
function M.filter_table(callback, tbl)
  local result = {}

  for _, item in ipairs(tbl) do
    if callback(item) then
      table.insert(result, item)
    end
  end

  return result
end

return M
