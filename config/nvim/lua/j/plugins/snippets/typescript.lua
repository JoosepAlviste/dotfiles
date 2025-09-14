local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep
local ensure_js_package_imported = require('j.treesitter_utils').ensure_js_package_imported

local s = ls.snippet
local d = ls.dynamic_node
local sn = ls.snippet_node
local i = ls.insert_node
local f = ls.function_node

ls.filetype_extend('typescript', { 'javascript' })

ls.add_snippets('typescript', {
  -- Fishery factory
  s(
    'factory',
    fmt(
      [[
export const {}Factory = Factory.define<{}>(({{ sequence }}) => ({{
  id: sequence,{}
}}));
    ]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),

  -- React `useState` declaration
  s(
    's',
    fmt([[const [{}, set{}] = useState({});]], {
      i(1, 'state'),
      f(function(args)
        return (args[1][1]:gsub('^%l', string.upper))
      end, { 1 }),
      i(2),
    })
  ),
})
