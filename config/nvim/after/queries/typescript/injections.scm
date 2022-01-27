; Inject Vue template syntax into Storybook stories files
(pair
  key: (property_identifier) @_key (#eq? @_key "template")
  value: (string
    (string_fragment) @vue))

(pair
  key: (property_identifier) @_key (#eq? @_key "template")
  value: (template_string) @vue)

(call_expression
  function: (await_expression
    (member_expression) @_name
      (#lua-match? @_name "request$"))
  arguments: (arguments
    (template_string) @graphql))
