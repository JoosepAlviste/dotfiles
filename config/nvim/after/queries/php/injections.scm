; inherits: php

(assignment_expression
  left: (variable_name
          (name) @_name (#eq? @_name "q"))
  right: (string
           (string_value) @sql))

(assignment_expression
  left: (variable_name
          (name) @_name (#eq? @_name "q"))
  right: (binary_expression
          (string
            (string_value) @sql)))

(scoped_call_expression
  scope: (name) @_scope (#eq? @_scope "ScoroDB")
  name: (name) @_function_name (#eq? @_function_name "run")
  arguments: (arguments
    (argument
      (string
        (string_value) @sql))))
