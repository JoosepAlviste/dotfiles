local parsers = require('nvim-treesitter.parsers')

local create_augroups = require('j.utils').create_augroups

local M = {}

-- This function is pretty much `get_node_at_cursor()` copied from 
-- `nvim-treesitter`, but instead will return the node that starts at the first 
-- non-whitespace column on the cursor's line.
--
-- For example, if the cursor is at "|":
--    |   <div>
--
-- then will return the <div> node, even though it isn't at the cursor position
local function get_node_at_cursor_start_of_line(winnr)
  if not parsers.has_parser() then return end
  local cursor = vim.api.nvim_win_get_cursor(winnr or 0)
  local root = parsers.get_parser():parse()[1]:root()

  local first_non_whitespace_col = vim.fn.match(vim.fn.getline('.'), '\\S')

  return root:named_descendant_for_range(
    cursor[1] - 1,
    first_non_whitespace_col,
    cursor[1] - 1,
    first_non_whitespace_col
  )
end

M.config = {
  typescriptreact = {
    jsx_element = '{/* %s */}',
    jsx_attribute = '// %s',
    comment = '// %s',
  },
  vue = {
    script_element = '// %s',
    template_element = '<!-- %s -->',
    style_element = '/* %s */',
  },
}

function M.setup()
  local file_types = vim.tbl_keys(M.config)

  local autocmds = vim.tbl_map(function (file_type)
    return {'FileType', file_type, [[lua require('j.context_commentstring').setup_filetype()]]}
  end, file_types)

  create_augroups({context_commentstring = autocmds})
end

function M.setup_filetype()
  -- Save the original commentstring so that it can be restored later
  vim.api.nvim_buf_set_var(0, 'original_commentstring', vim.api.nvim_buf_get_option(0, 'commentstring'))

  create_augroups({
    context_commentstring_ft = {
      {'CursorHold', '*', [[lua require('j.context_commentstring').update_commentstring()]]},
    },
  })
end

function M.update_commentstring()
  local node = get_node_at_cursor_start_of_line()
  local looking_for = M.config[vim.bo.ft]

  if looking_for then
    local found_type = M.check_node(node, looking_for)

    if found_type then
      vim.api.nvim_buf_set_option(0, 'commentstring', looking_for[found_type])
    else
      vim.api.nvim_buf_set_option(0, 'commentstring', vim.api.nvim_buf_get_var(0, 'original_commentstring'))
    end
  end
end

function M.check_node(node, looking_for)
  if not node then return nil end

  local type = node:type()
  local match = looking_for[type]

  if match then return type end

  -- Recursively check the parent node
  return M.check_node(node:parent(), looking_for)
end

return M
