local ls = require 'luasnip'

local s = ls.s
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets('lua', {
  -- Require statement
  s(
    'req',
    fmt([[local {} = require('{}')]], {
      f(function(import_name)
        local parts = vim.split(import_name[1][1], '.', true)
        return parts[#parts] or ''
      end, { 1 }),
      i(1),
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

  -- If statement
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
