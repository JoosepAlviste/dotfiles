local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local s = ls.snippet
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local c = ls.choice_node
local t = ls.text_node

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
  s(
    'desc',
    fmt(
      [[
describe('{}', () => {{
  {}
}});
]],
      {
        d(1, function(_, snip)
          P(snip.env.TM_DIRECTORY:gsub(vim.pesc(vim.loop.cwd()), '.'))
          local filename, _ = (snip.env.TM_DIRECTORY .. '/' .. snip.env.TM_FILENAME_BASE):gsub(
            vim.pesc(vim.loop.cwd() .. '/'),
            ''
          )
          local filename_without_test, _ = filename:gsub('^test/', '')
          local filename_without_extension, _ = filename_without_test:gsub('.spec$', '')

          return sn(nil, {
            i(1, filename_without_extension),
          })
        end, { 1 }),
        i(2),
      }
    )
  ),
  s(
    'it',
    fmt(
      [[
it('{}', {}() => {{
  {}
}});
]],
      { i(1), c(2, { t 'async ', t '' }), i(3) }
    )
  ),
})
