local parsers = require 'nvim-treesitter.parsers'
local ts_utils = require 'nvim-treesitter.ts_utils'

local M = {}

---@param location {number}
---@param winnr? number
---@param ignore_injected_langs? boolean
function M.get_node_at_location(location, winnr, ignore_injected_langs)
  winnr = winnr or 0

  local buf = vim.api.nvim_win_get_buf(winnr)
  local root_lang_tree = parsers.get_parser(buf)
  if not root_lang_tree then
    return
  end

  local root
  if ignore_injected_langs then
    for _, tree in ipairs(root_lang_tree:trees()) do
      local tree_root = tree:root()
      if tree_root and ts_utils.is_in_node_range(tree_root, location[1], location[2]) then
        root = tree_root
        break
      end
    end
  else
    root = ts_utils.get_root_for_position(location[1], location[2], root_lang_tree)
  end

  if not root then
    return
  end

  return root:named_descendant_for_range(location[1], location[2], location[1], location[2])
end

return M
