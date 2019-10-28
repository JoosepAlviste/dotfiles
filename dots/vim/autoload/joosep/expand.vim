function! joosep#expand#expand()
  " Make a double new line and indent correctly if the cursor is between a
  " some start and end symbols (HTML tags, parenthesis, etc.)

  let line   = getline('.')
  let col    = col('.')
  let first  = line[col-2]
  let second = line[col-1]
  let third  = line[col]

  function! IsBetween(a, b)
    " Helper function to check if the cursor is between the given symbols
    let line   = getline('.')
    let col    = col('.')
    let first  = line[col-2]
    let second = line[col-1]
    return first ==# a:a && second ==# a:b
  endfunction

  let is_between_tags = IsBetween('>', '<') && third ==# '/'
  let is_between_backticks = IsBetween('`', '`')
  let is_between_parenthesis = IsBetween('(', ')')
  let is_between_brackets = IsBetween('[', ']')
  let is_between_braces = IsBetween('{', '}')

  let should_trigger = is_between_tags
        \ || is_between_backticks
        \ || is_between_parenthesis
        \ || is_between_brackets
        \ || is_between_braces

  if should_trigger
    return "\<CR>\<C-o>==\<C-o>O"
  else
    return "\<CR>"
  endif
endfunction

function! joosep#expand#insertComma()
    " When creating a new line with o, make sure there is a trailing comma on
    " the current line

    " Add the trailing comma if it doesn't exist
    substitute/\(.*[^{[][^,{[]\)$/\1,/g
    " And add the new line
    call feedkeys("A\<cr>")
endfunction
