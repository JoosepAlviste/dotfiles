local ls = require 'luasnip'

local s = ls.s
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.insert_node

ls.add_snippets('javascript', {
  s(
    'log',
    fmt('console.log({});', {
      i(1),
    })
  ),
  s(
    'f',
    fmt(
      [[
{}const {} = ({}) => {{
  {}
}};
]],
      {
        i(1, 'export '),
        i(2),
        i(3),
        i(4),
      }
    )
  ),
  s(
    'if',
    fmt(
      [[
if ({}) {{
  {}
}}
]],
      { i(1), i(2) }
    )
  ),
})
