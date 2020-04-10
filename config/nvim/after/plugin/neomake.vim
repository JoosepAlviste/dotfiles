"
" Settings
"

let g:neomake_open_list = 2

let g:neomake_warning_sign = {
      \   'text': '◉',
      \ }
let g:neomake_error_sign = {
      \   'text': '◉',
      \ }


"
" Autocommands
" ============
" Keep track of the status of the running tests
"

let g:TestingStatus = 'waiting'

function! MyOnNeomakeJobStarted() abort
  let g:TestingStatus = 'running'
endfunction

function! MyOnNeomakeJobFinished() abort
  let context = g:neomake_hook_context
  if context.jobinfo.exit_code == 0
    let g:TestingStatus = 'passing'
  endif
  if context.jobinfo.exit_code == 1
    let g:TestingStatus = 'failing'
  endif
endfunction

augroup MyNeomakeAutocmds
  autocmd!
  autocmd User NeomakeJobFinished call MyOnNeomakeJobFinished()
  autocmd User NeomakeJobStarted call MyOnNeomakeJobStarted()
augroup END
