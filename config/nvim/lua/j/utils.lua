local M = {}

function M.termcode(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

---@param filename string
---@return table | nil
function M.read_json_file(filename)
  local Path = require 'plenary.path'

  local path = Path:new(filename)
  if not path:exists() then
    return nil
  end

  local json_contents = path:read()
  local json = vim.fn.json_decode(json_contents)

  return json
end

function M.read_package_json()
  return M.read_json_file 'package.json'
end

---Check if the given NPM package is installed in the current project.
---@param package string
---@return boolean
function M.is_npm_package_installed(package)
  local package_json = M.read_package_json()
  if not package_json then
    return false
  end

  if package_json.dependencies and package_json.dependencies[package] then
    return true
  end

  if package_json.devDependencies and package_json.devDependencies[package] then
    return true
  end

  return false
end

---@param path string
---@return string
function M.shorten_path_relative(path)
  return path
    -- Remove CWD
    :gsub(vim.pesc(vim.loop.cwd()) .. '/', '')
    -- Remove home dir
    :gsub(vim.pesc(vim.fn.expand '$HOME'), '~')
    -- Remove trailing slash
    :gsub('/$', '')
end

---@param path string
---@return string
function M.shorten_path_absolute(path)
  return path:gsub(vim.pesc(vim.fn.expand '$HOME'), '~')
end

---@param ignored_filetypes? string[]
function M.close_all_floating_windows(ignored_filetypes)
  ignored_filetypes = ignored_filetypes or {}

  for _, window in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(window)

    local bufnr = vim.fn.winbufnr(window)
    local buf_filetype = vim.fn.getbufvar(bufnr, '&filetype')
    if config.relative ~= '' and not vim.tbl_contains(ignored_filetypes, buf_filetype) then
      vim.api.nvim_win_close(window, false)
    end
  end
end

-- Useful function for debugging
-- Print the given items
function _G.P(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

return M
