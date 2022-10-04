local fn = vim.fn

local M = {}

-- Show some information about the syntax group under the cursor
function M.print_syntax()
  local syn_stack = fn.synstack(fn.line '.', fn.col '.')
  local syn_names = vim.tbl_map(function(elem)
    return fn.synIDattr(elem, 'name')
  end, syn_stack)

  P(syn_names)
end

return M
