local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local rep = require('luasnip.extras').rep

local function capitalized(args)
  return (args[1][1]:gsub('^%l', string.upper))
end

ls.add_snippets('php', {
  -- Setter
  s(
    'set',
    fmt(
      [[
public function set{}({} ${}): void {{
	$this->{} = ${};
}}
]],
      {
        f(capitalized, { 1 }),
        i(2),
        rep(1),
        i(1),
        rep(1),
      }
    )
  ),
  -- Getter and setter
  s(
    'getset',
    fmt(
      [[
public function get{}(): {} {{
	return $this->{};
}}

public function set{}({} ${}): void {{
	$this->{} = ${};
}}
]],
      {
        f(capitalized, { 1 }),
        i(2),
        i(1),
        f(capitalized, { 1 }),
        rep(2),
        rep(1),
        rep(1),
        rep(1),
      }
    )
  ),
})
