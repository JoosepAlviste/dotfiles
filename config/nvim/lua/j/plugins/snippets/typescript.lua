local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep
local ensure_js_package_imported = require('j.treesitter').ensure_js_package_imported

local s = ls.snippet
local d = ls.dynamic_node
local sn = ls.snippet_node
local i = ls.insert_node
local f = ls.function_node

ls.filetype_extend('typescript', { 'javascript' })

ls.add_snippets('typescript', {
  -- Storybook story
  s(
    'story',
    fmt(
      [[
{}{}import {} from './{}.vue';

export default {{
	title: '{}',
	component: {},
	argTypes: {{
		{}
	}},
}} as Meta;

export const Default: Story = (args) => ({{
	components: {{ {} }},
	setup() {{
		return {{ args }};
  }},
	template: `
		<{} v-bind="args" />
	`,
}});
]],
      {
        f(ensure_js_package_imported('Meta', '@storybook/vue')),
        f(ensure_js_package_imported('Story', '@storybook/vue')),
        d(1, function(_, snip)
          local filename_without_extension, _ = snip.env.TM_FILENAME_BASE:gsub('.stories$', '')

          return sn(nil, {
            i(1, filename_without_extension),
          })
        end),
        rep(1),
        i(2),
        rep(1),
        i(3),
        rep(1),
        rep(1),
      }
    )
  ),

  -- Fishery factory
  s(
    'factory',
    fmt(
      [[
{}export const {}Factory = Factory.define<{}>(({{ sequence }}) => ({{
  id: sequence,{}
}}));
    ]],
      {
        f(ensure_js_package_imported('Factory', 'fishery')),
        i(1),
        i(2),
        i(3),
      }
    )
  ),
})
