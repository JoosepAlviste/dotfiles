local M = {}

---When typing "await" add "async" to the function declaration if the function
---isn't async already.
function M.add_async()
  -- This function should be executed when the user types "t" in insert mode,
  -- but "t" is not inserted because it's the trigger.
  vim.api.nvim_feedkeys('t', 'n', true)

  local text_before_cursor = vim.fn.getline('.'):sub(vim.fn.col '.' - 4, vim.fn.col '.' - 1)
  if text_before_cursor ~= 'awai' then
    return
  end

  local current_node = vim.treesitter.get_node { ignore_injections = false }
  local function_node = require('j.treesitter_utils').find_node_ancestor(
    { 'arrow_function', 'function_declaration', 'function', 'method_definition' },
    current_node
  )
  if not function_node then
    return
  end

  local function_text = vim.treesitter.get_node_text(function_node, 0)
  if vim.startswith(function_text, 'async ') then
    return
  end

  local start_row, start_col = function_node:start()
  vim.api.nvim_buf_set_text(0, start_row, start_col, start_row, start_col, { 'async ' })
end

return M
