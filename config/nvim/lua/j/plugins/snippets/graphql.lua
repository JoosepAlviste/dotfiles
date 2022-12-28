local ls = require 'luasnip'

local s = ls.s
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.insert_node
local sn = ls.snippet_node
local f = ls.function_node

ls.add_snippets('graphql', {
  -- GraphQL query
  s(
    'q',
    fmt(
      [[
query {}{} {{
  {}
}}
]],
      {
        d(1, function(_, snip)
          -- local parts = vim.split(import_name[1][1], '.', true)
          local filename_without_extension, _ = snip.env.TM_FILENAME_BASE:gsub('Query$', '')

          return sn(nil, {
            i(1, filename_without_extension),
          })
        end),
        i(3, '($id: Int!)'),
        i(2, 'myQuery'),
      }
    )
  ),
})
