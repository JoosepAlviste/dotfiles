"
" Configuration
"

" \   'typescript': ['tsserver', 'tslint'],
let g:ale_linters = {
            \ 'javascript': [],
            \ 'typescript': [],
            \ 'vue': ['eslint'],
            \ 'java': [],
            \ 'python': [],
            \}

let g:ale_fixers = {
            \ 'javascript': [],
            \ 'typescript': [],
            \ 'vue': ['eslint'],
            \ 'scss': ['prettier'],
            \ 'html': ['prettier'],
            \}

let g:ale_fix_on_save = 1

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
