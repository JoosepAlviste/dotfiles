local map = require('j.utils').map

-- CSS classes usually have dashes in them, so the whole class name should be
-- considered as a word
vim.opt_local.iskeyword:append '-'

-- Mappings for navigating blocks
map('n', ']]', function()
  vim.fn.search('^<(template<bar>script<bar>style)', 'W')
end)
map('n', '[[', function()
  vim.fn.search('^<(template<bar>script<bar>style)', 'bW')
end)

-- Automatically end a self-closing tag when pressing /
vim.keymap.set('i', '/', function()
  local ts_utils = require 'nvim-treesitter.ts_utils'

  local node = ts_utils.get_node_at_cursor()
  if not node then
    return '/'
  end

  local first_sibling_node = node:prev_named_sibling()
  if not first_sibling_node then
    return '/'
  end

  local parent_node = node:parent()
  local is_tag_writing_in_progress = node:type() == 'text' and parent_node:type() == 'element'

  local is_start_tag = first_sibling_node:type() == 'start_tag'

  local start_tag_text = vim.treesitter.query.get_node_text(first_sibling_node, 0)
  local tag_is_already_terminated = string.match(start_tag_text, '>$')

  if is_tag_writing_in_progress and is_start_tag and not tag_is_already_terminated then
    local char_at_cursor = vim.fn.strcharpart(vim.fn.strpart(vim.fn.getline '.', vim.fn.col '.' - 2), 0, 1)
    local already_have_space = char_at_cursor == ' '

    return already_have_space and '/>' or ' />'
  end

  return '/'
end, { expr = true, buffer = true })

-- Inside an attribute: <button type| pressing = -> <button type="|"
vim.keymap.set('i', '=', function()
  local ts_utils = require 'j.ts_utils'

  local cursor = vim.api.nvim_win_get_cursor(0)
  local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }

  -- The cursor location does not give us the correct node in this case, so we
  -- need to get the node to the left of the cursor
  local node = ts_utils.get_node_at_location(left_of_cursor_range)
  local nodes_active_in = { 'attribute_name', 'directive_argument', 'directive_name' }
  if not node or not vim.tbl_contains(nodes_active_in, node:type()) then
    return '='
  end

  return '=""<left>'
end, { expr = true, buffer = true })
