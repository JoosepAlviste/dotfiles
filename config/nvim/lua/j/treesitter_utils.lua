local M = {}

local function get_language_tree_for_cursor_location()
  local bufnr = 0
  local cursor = vim.api.nvim_win_get_cursor(bufnr)
  local language_tree =
    vim.treesitter.get_parser(bufnr):language_for_range { cursor[1], cursor[2], cursor[1], cursor[2] }

  return language_tree
end

---@param language string
---@param imported_items string
---@param package string
---@return boolean True if the import was added, false if it already existed
local function ensure_package_imported(tree, language, imported_items, package)
  local bufnr = 0

  local query = vim.treesitter.query.parse(
    language,
    string.format(
      [[
(import_statement
  source: (string
            (string_fragment) @import_from (#eq? @import_from "%s")))]],
      package
    )
  )
  for _, _ in query:iter_matches(tree:root(), bufnr) do
    return false
  end

  local start_line = tree:root():start()

  vim.api.nvim_buf_set_text(
    bufnr,
    start_line,
    0,
    start_line,
    0,
    { string.format("import %s from '%s'", imported_items, package), '', '' }
  )
  return true
end

---@param language string
---@param variable_name string
---@param package string
local function ensure_variable_imported(tree, language, variable_name, package)
  local bufnr = 0

  local query = vim.treesitter.query.parse(
    language,
    string.format(
      [[
(import_statement
  (import_clause
    (named_imports
      (import_specifier) @variable (#eq? @variable "%s")))
  source: (string
            (string_fragment) @import_from (#eq? @import_from "%s")))]],
      variable_name,
      package
    )
  )
  for _, _ in query:iter_matches(tree:root(), bufnr) do
    -- If the variable is imported, then the loop will be executed at least once
    return false
  end

  query = vim.treesitter.query.parse(
    language,
    string.format(
      [[
(import_statement
  (import_clause (named_imports) @import_clause)
  source: (string
            (string_fragment) @import_from (#eq? @import_from "%s")))]],
      package
    )
  )
  for _, match, _ in query:iter_matches(tree:root(), bufnr) do
    for id, node in pairs(match) do
      local name = query.captures[id]
      if name == 'import_clause' then
        local start_row, start_col = node:start()

        vim.api.nvim_buf_set_text(
          bufnr,
          start_row,
          start_col + 1,
          start_row,
          start_col + 1,
          { string.format('%s, ', variable_name) }
        )
      end
    end
  end

  return true
end

---Automatically import the variable from the given package. Add it to a snippet
---as a function node:
---```lua
---f(ensure_package_imported('useState', 'react'))
---```
---@param variable_name string
---@param package string
function M.ensure_js_package_imported(variable_name, package)
  return function()
    local language_tree = get_language_tree_for_cursor_location()
    local tree = language_tree:parse()[1]
    local language = language_tree._lang

    ensure_package_imported(tree, language, string.format('{ %s }', variable_name), package)
    ensure_variable_imported(tree, language, variable_name, package)

    return nil
  end
end

return M
