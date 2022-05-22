local ls = require 'luasnip'

local s = ls.s
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.insert_node

ls.filetype_extend('vue', { 'typescript', 'javascript' })

ls.add_snippets('vue', {
  -- Function declaration
  s(
    'f',
    fmt(
      [[
const {} = ({}) => {{
  {}
}};
]],
      { i(1), i(2), i(3) }
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
      { i(1) }
    )
  ),

  -- Vue component
  s(
    'comp',
    fmt(
      [[
<template>
  <div />
</template>

<script lang="ts">
import {{ defineComponent }} from '@vue/composition-api';

export default defineComponent({{
  setup() {{
    {}
  }},
}});
</script>

<style lang="scss" scoped>
</style>
]],
      { i(1) }
    )
  ),
})
