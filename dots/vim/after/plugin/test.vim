let g:test#strategy = 'neomake'
let g:test#javascript#jest#options = '--reporters jest-vim-reporter'

function! TypeScriptTransform(cmd) abort
  return substitute(a:cmd, '\v(.*)jest', '\1ts-jest', '')
endfunction
let g:test#custom_transformations = {'typescript': function('TypeScriptTransform')}
let g:test#transformation = 'typescript'

let g:neomake_warning_sign = {
  \   'text': '◉'
  \ }
let g:neomake_error_sign = {
  \   'text': '◉'
  \ }

let g:neomake_open_list = 1

" Show message that tests have started
function! MyOnNeomakeJobStarted() abort
    let g:TESTING_STATUS = 'running'
    echo 'Running tests...'
endfunction

" Show message when all tests are passing
function! MyOnNeomakeJobFinished() abort
    let context = g:neomake_hook_context
    if context.jobinfo.exit_code == 0
        let g:TESTING_STATUS = 'passing'
        echo 'Tests passed!'
    endif
    if context.jobinfo.exit_code == 1
        let g:TESTING_STATUS = 'failing'
        echo 'Tests failed!'
    endif
endfunction

augroup my_neomake_hooks
    au!
    autocmd User NeomakeJobFinished call MyOnNeomakeJobFinished()
    autocmd User NeomakeJobStarted call MyOnNeomakeJobStarted()
augroup END
