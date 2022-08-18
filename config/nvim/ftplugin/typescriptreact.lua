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
