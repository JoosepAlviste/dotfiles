; Custom queries

(element
  (start_tag)
  .
  (_) @function.inner
  .
  (end_tag))

; Default queries

(element) @function.outer

[
  (attribute)
  (directive_attribute)
] @call.outer

(attribute_value) @parameter.outer
