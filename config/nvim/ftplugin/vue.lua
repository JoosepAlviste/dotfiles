-- CSS classes usually have dashes in them, so the whole class name should be
-- considered as a word
vim.opt_local.iskeyword:append '-'

-- Mappings for navigating blocks
vim.keymap.set('n', ']]', function()
  vim.fn.search('^<\\(template\\|script\\|style\\)', 'W')
end, { buffer = true })
vim.keymap.set('n', '[[', function()
  vim.fn.search('^<\\(template\\|script\\|style\\)', 'bW')
end, { buffer = true })

-- Automatically end a self-closing tag when pressing /
vim.keymap.set('i', '/', function()
  local node = vim.treesitter.get_node()
  if not node then
    return '/'
  end

  local child_node = node:child(0)
  if not child_node then
    return '/'
  end

  local is_writing_start_tag = node:type() == 'element' and child_node:type() == 'start_tag'
  local start_tag_text = vim.treesitter.get_node_text(child_node, 0)
  local is_tag_terminated = string.match(start_tag_text, '>$')

  if is_writing_start_tag and not is_tag_terminated then
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
  local nodes_active_in = { 'attribute_name', 'directive_value', 'directive_argument', 'directive_name' }
  if not node or not vim.tbl_contains(nodes_active_in, node:type()) then
    return '='
  end

  return '=""<left>'
end, { expr = true, buffer = true })

vim.keymap.set('i', 't', require('j.javascript').add_async, { buffer = true })
