; Inject Vue template syntax into Storybook stories files
(pair
  key: (property_identifier) @_key (#eq? @_key "template")
  value: (string
    (string_fragment) @vue))

(pair
  key: (property_identifier) @_key (#eq? @_key "template")
  value: (template_string) @vue)
