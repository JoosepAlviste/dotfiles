; inherits: ecma

(call_expression
 function: ((identifier) @_name
   (#eq? @_name "graphql"))
 arguments: ((arguments
   (template_string) @graphql)))
