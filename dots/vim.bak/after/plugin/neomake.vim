"
" Settings
"

let g:neomake_warning_sign = {
            \ 'text': '◉',
            \ 'texthl': 'CocWarningSign',
            \ }
let g:neomake_error_sign = {
            \ 'text': '◉',
            \ 'texthl': 'CocErrorSign',
            \ }

let g:neomake_open_list = 2
let g:neomake_echo_current_error = 0

let g:TestingStatus = 'waiting'


"
" Autocommands
"

" Show message that tests have started
function! MyOnNeomakeJobStarted() abort
    let g:TestingStatus = 'running'
endfunction

" Show message when all tests are passing
function! MyOnNeomakeJobFinished() abort
    let context = g:neomake_hook_context
    if context.jobinfo.exit_code == 0
        let g:TestingStatus = 'passing'
    endif
    if context.jobinfo.exit_code == 1
        let g:TestingStatus = 'failing'
    endif
endfunction

augroup my_neomake_hooks
    au!
    autocmd User NeomakeJobFinished call MyOnNeomakeJobFinished()
    autocmd User NeomakeJobStarted call MyOnNeomakeJobStarted()
augroup END
