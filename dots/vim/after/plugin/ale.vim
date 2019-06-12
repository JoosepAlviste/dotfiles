"
" Configuration
"

" \   'typescript': ['tsserver', 'tslint'],
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': [],
\   'vue': ['eslint'],
\   'java': [],
\}

let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'typescript': [],
\    'vue': ['eslint'],
\    'scss': ['prettier'],
\    'html': ['prettier'],
\}

let g:ale_fix_on_save = 1

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
