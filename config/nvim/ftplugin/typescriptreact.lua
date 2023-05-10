-- Automatically end a self-closing tag when pressing /
vim.keymap.set('i', '/', function()
  local ts_utils = require 'nvim-treesitter.ts_utils'

  local node = ts_utils.get_node_at_cursor()
  if not node then
    return '/'
  end

  if node:type() == 'jsx_opening_element' then
    local char_at_cursor = vim.fn.strcharpart(vim.fn.strpart(vim.fn.getline '.', vim.fn.col '.' - 2), 0, 1)
    local already_have_space = char_at_cursor == ' '

    return already_have_space and '/>' or ' />'
  end

  return '/'
end, { expr = true, buffer = true })

-- Inside an attribute: <button type| pressing = -> <button type="|"
vim.keymap.set('i', '=', function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }

  -- The cursor location does not give us the correct node in this case, so we
  -- need to get the node to the left of the cursor
  local node = vim.treesitter.get_node { pos = left_of_cursor_range }
  local parent_node = node:parent()

  if node and parent_node and parent_node:type() == 'jsx_attribute' and node:type() == 'property_identifier' then
    return '=""<left>'
  end

  return '='
end, { expr = true, buffer = true })
