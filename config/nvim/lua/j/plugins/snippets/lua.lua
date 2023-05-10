local ls = require 'luasnip'

local s = ls.s
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets('lua', {
  -- Require statement
  s(
    'req',
    fmt([[local {} = require('{}'){}]], {
      f(function(args)
        local imported_variable = args[2][1]
        if #imported_variable > 0 then
          return string.sub(imported_variable, 2)
        end

        local import_name = args[1][1]
        local parts = vim.split(import_name, '.', true)
        return parts[#parts] or ''
      end, { 1, 2 }),
      i(1),
      i(2),
    })
  ),

  -- Function declaration
  s(
    'f',
    fmt(
      [[
function({})
  {}
end
  ]],
      { i(1), i(2) }
    )
  ),

  -- Local function declaration
  s(
    'lf',
    fmt(
      [[
local {} = function({})
  {}
end
  ]],
      { i(1), i(2), i(3) }
    )
  ),
})

ls.add_snippets('lua', {
  -- If statement
  s(
    {
      trig = 'if',
      condition = function()
        local ignored_nodes = { 'string', 'comment' }

        local pos = vim.api.nvim_win_get_cursor(0)
        -- Use one column to the left of the cursor to avoid a "chunk" node
        -- type. Not sure what it is, but it seems to be at the end of lines in
        -- some cases.
        local row, col = pos[1] - 1, pos[2] - 1

        local node_type = vim.treesitter
          .get_node({
            pos = { row, col },
          })
          :type()

        return not vim.tbl_contains(ignored_nodes, node_type)
      end,
    },
    fmt(
      [[
if {} then
  {}
end
  ]],
      { i(1), i(2) }
    )
  ),
}, {
  type = 'autosnippets',
})
