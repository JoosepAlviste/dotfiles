local ls = require 'luasnip'

local s = ls.s
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets('lua', {
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
})
