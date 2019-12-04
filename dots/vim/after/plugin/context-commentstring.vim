"
" Customize the comment strings some file types.
"

" Have the same commentstrings inside JavaScript files (no .jsx extension)
let g:context#commentstring#table.javascript = g:context#commentstring#table['javascript.jsx']
