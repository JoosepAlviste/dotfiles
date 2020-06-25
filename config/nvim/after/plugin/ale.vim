let g:ale_fix_on_save = 1
let g:ale_set_signs = 0
let g:ale_lint_on_text_changed = 'never'

let g:ale_python_auto_pipenv = 1
let g:ale_python_prospector_auto_pipenv = 1
" let g:ale_python_prospector_options = '--profile subfolder/.prospector.yaml'

nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)
