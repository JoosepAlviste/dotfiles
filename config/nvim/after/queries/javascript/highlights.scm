; React component usually has this type of a name (first letter is the capital 
; letter)
((identifier) @constructor
 (#match? @constructor "^[A-Z]"))

((identifier) @constant
 (#match? @constant "^[A-Z_][A-Z\\d_]+$"))

(null) @constant.builtin

((identifier) @variable.builtin
 (#match? @variable.builtin "^(arguments|module|console|window|document)$"))

((identifier) @function.builtin
 (#eq? @function.builtin "require"))

(this) @keyword


; Standard text

(property_identifier) @identifier

(shorthand_property_identifier) @identifier


; Functions

(call_expression
  function: (member_expression
    property: (property_identifier) @function))

(call_expression
  function: (identifier) @function)

(variable_declarator
  name: (identifier) @function
  value: (arrow_function))

(variable_declarator
  name: ((identifier) @constructor
   (#match? @constructor "^[A-Z]"))
  value: (arrow_function))

(arrow_function
 "=>" @include)

(public_field_definition
 property: (property_identifier) @function
 value: (arrow_function))

(method_definition
 name: (property_identifier) @function)


; Punctuation

(pair) @punctuation.delimiter

(template_substitution
  "${" @punctuation.special
  "}" @punctuation.special) @embedded


; Operators

(ternary_expression
  "?" @operator
  ":" @operator)

(unary_expression
  operator: (["!" "+" "-" "~"]) @operator)
