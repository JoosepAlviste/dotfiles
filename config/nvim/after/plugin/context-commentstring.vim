"
" Customize the comment strings some file types.
"

" Have the same commentstrings inside JavaScript files (no .jsx extension)
let g:context#commentstring#table.javascript = g:context#commentstring#table['javascript.jsx']
let g:context#commentstring#table.typescriptreact = g:context#commentstring#table['typescript.tsx']
let g:context#commentstring#table.typescriptreact['typescriptBlock'] = '// %s'
let g:context#commentstring#table.typescriptreact['tsxAttrib'] = '// %s'
let g:context#commentstring#table.typescriptreact['styledDefinition'] = '/* %s */'
let g:context#commentstring#table.vue['vue_typescript'] = '// %s'
