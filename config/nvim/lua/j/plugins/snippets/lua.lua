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
    'if',
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
