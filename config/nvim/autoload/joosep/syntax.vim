" Show some more information about the syntax group under the cursor (not
" sure how this is different from the other function tbh)
function! joosep#syntax#PrintSyntax()
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
