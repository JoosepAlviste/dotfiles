local ls = require 'luasnip'
local ensure_js_package_imported = require('j.treesitter_utils').ensure_js_package_imported
local is_marketer_repo = require('j.modash').is_marketer_repo

local fmt = require('luasnip.extras.fmt').fmt
local s = ls.snippet
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local c = ls.choice_node
local t = ls.text_node
local f = ls.function_node

ls.add_snippets('javascript', {
  -- console.log statement
  s(
    'log',
    fmt('console.log({});', {
      i(1),
    })
  ),

  -- Function declaration
  s(
    'f',
    fmt(
      [[
{}const {} = ({}) => {{
  {}
}};
]],
      {
        d(1, function()
          local node = vim.treesitter.get_node()
          if not node or node:type() == 'program' then
            -- Only suggest adding `export` if  at the top level
            return sn(nil, { i(1, 'export ') })
          end

          return sn(nil, { t '' })
        end),
        i(2),
        i(3),
        i(4),
      }
    )
  ),

  -- If statement
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

  -- Export statement
  s(
    'export',
    fmt([[export {{ {} }} from './{}';]], {
      d(2, function(args)
        return sn(nil, {
          i(1, args[1][1]),
        })
      end, { 1 }),
      i(1),
    })
  ),

  -- Component index file export
  s(
    'indexport',
    fmt([[export {{ default }} from './{}';]], {
      d(1, function()
        local folder_name = vim.fn.expand '%:h:t'
        return sn(nil, {
          c(1, { i(nil, folder_name), i(nil, folder_name .. '.vue') }),
        })
      end),
    })
  ),

  -- Export all statement
  s(
    'exportall',
    fmt([[export * from './{}';]], {
      i(1),
    })
  ),

  -- Test describe block
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
          local filename, _ = (snip.env.TM_DIRECTORY .. '/' .. snip.env.TM_FILENAME_BASE):gsub(
            vim.pesc(vim.loop.cwd() .. '/'),
            ''
          )
          local filename_without_extension = vim.fn.fnamemodify(snip.env.TM_FILENAME_BASE, ':r:r')

          local filename_without_junk, _ = filename
            :gsub('^test/', '')
            :gsub('^src/', '')
            :gsub('.spec$', '')
            :gsub('.test$', '')
            :gsub('__tests__/', '')
            :gsub(filename_without_extension .. '/' .. filename_without_extension .. '$', filename_without_extension)

          return sn(nil, {
            i(1, filename_without_junk),
          })
        end),
        i(2),
      }
    )
  ),

  -- Test case
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

  -- Computed variable
  s(
    'computed',
    fmt(
      [[
const {} = computed(() => {});
  ]],
      {
        i(1),
        c(2, {
          fmt(
            [[
{{
  return {}
}}
]],
            { i(1) }
          ),
          i(nil, ''),
        }),
      }
    )
  ),

  -- Vanilla Extract style declaration
  s(
    'style',
    fmt(
      [[
export const {} = style({{
  {}
}})
  ]],
      {
        i(1),
        i(2),
      }
    )
  ),

  -- Debugging composables with watchEffect
  s(
    'debug',
    fmt(
      [[
watchEffect(() => {{
  console.log({{ {} }})
}});
]],
      {
        i(1),
      }
    )
  ),

  -- Ref
  s(
    'r',
    fmt([[const {} = ref({})]], {
      i(1),
      i(2),
    })
  ),
})
