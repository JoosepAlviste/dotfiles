"
" Customize the comment strings some file types.
"

" Have the same commentstrings inside JavaScript files (no .jsx extension)
let g:context#commentstring#table.javascript = g:context#commentstring#table['javascript.jsx']

let g:context#commentstring#table.typescriptreact = g:context#commentstring#table['typescript.tsx']
let g:context#commentstring#table.typescriptreact['typescriptBlock'] = '// %s'
let g:context#commentstring#table.typescriptreact['tsxAttrib'] = '// %s'
let g:context#commentstring#table.typescriptreact['jsxRegion'] = '{/* %s */}'
let g:context#commentstring#table.typescriptreact['styledDefinition'] = '/* %s */'

let g:context#commentstring#table.vue['vue_typescript'] = '// %s'
let g:context#commentstring#table.vue['typescriptVueScript'] = '// %s'
let g:context#commentstring#table.vue['cssVueStyle'] = '/* %s */'
let g:context#commentstring#table.vue['cssScssVueStyle'] = '// %s'

let g:context#commentstring#comments_table.vue['typescriptVueScript'] = 's1:/*,mb:*,ex:*/,://'
let g:context#commentstring#comments_table.vue['cssVueStyle'] = 's1:/*,mb:*,ex:*/,://'
let g:context#commentstring#comments_table.vue['cssScssVueStyle'] = 's1:/*,mb:*,ex:*/,://'
let g:context#commentstring#comments_table.vue['htmlVueTemplate'] = 's:<!--,m:    ,e:-->'
