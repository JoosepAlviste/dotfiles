let g:test#strategy = 'neomake'

let g:test#javascript#jest#options = '--reporters ' . $HOME . '/.config/yarn/global/node_modules/jest-vim-reporter'
" let g:TESTING_STATUS = ''

" " let g:root_markers = ['package.json', '.git/']
" " function! s:RunVimTest(cmd)
" "     echom 'running test' a:cmd
" "     for marker in g:root_markers
" "         let marker_file = findfile(marker, expand('%:p:h') . ';')
" "         if strlen(marker_file) > 0
" "             let g:test#project_root = fnamemodify(marker_file, ":p:h")
" "             break
" "         endif
" "         let marker_dir = finddir(marker, expand('%:p:h') . ';')
" "         if strlen(marker_dir) > 0
" "             let g:test#project_root = fnamemodify(marker_dir, ":p:h")
" "             break
" "         endif
" "     endfor

" "     execute a:cmd
" " endfunction

" " nnoremap <leader>tf :call <SID>RunVimTest('TestFile')<cr>
" " nnoremap <leader>tn :call <SID>RunVimTest('TestNearest')<cr>
" " nnoremap <leader>tf :call <SID>RunVimTest('TestSuite')<cr>
" " nnoremap <leader>ts :call <SID>RunVimTest('TestFile')<cr>
" " nnoremap <leader>tl :call <SID>RunVimTest('TestLast')<cr>
" " nnoremap <leader>tv :call <SID>RunVimTest('TestVisit')<cr>

" " " function! TypeScriptTransform(cmd) abort
" " "   return substitute(a:cmd, '\v(.*)jest', '\1jest', '')
" " " endfunction
" " " let g:test#custom_transformations = {'typescript': function('TypeScriptTransform')}
" " " let g:test#transformation = 'typescript'

" " " function! JavascriptTransform(cmd) abort
" " "     let package_json = findfile('package.json', expand('%:p:h') . ';' . getcwd())
" " "     let javascript_project = fnamemodify(package_json, ":p:h")
" " "     echom javascript_project
" " "     return 'cd '.javascript_project . '; ' . a:cmd
" " "     " return shellescape('cd "'.javascript_project.'"; '.a:cmd)
" " " endfunction

" " " let g:test#custom_transformations = {'javascript': function('JavascriptTransform')}
" " " let g:test#transformation = 'javascript'

let g:neomake_warning_sign = {
  \     'text': '◉',
  \     'texthl': 'CocWarningSign',
  \ }
let g:neomake_error_sign = {
  \     'text': '◉',
  \     'texthl': 'CocErrorSign',
  \ }

let g:neomake_open_list = 1

" " " Show message that tests have started
" function! MyOnNeomakeJobStarted() abort
"     let g:TESTING_STATUS = 'running'
"     echo 'Running tests...'
" endfunction

" " Show message when all tests are passing
" function! MyOnNeomakeJobFinished() abort
"     let context = g:neomake_hook_context
"     echo context.jobinfo
"     if context.jobinfo.exit_code == 0
"         let g:TESTING_STATUS = 'passing'
"         echo 'Tests passed!'
"     endif
"     if context.jobinfo.exit_code == 1
"         let g:TESTING_STATUS = 'failing'
"         echo 'Tests failed!'
"     endif
" endfunction

" augroup my_neomake_hooks
"     au!
"     autocmd User NeomakeJobFinished call MyOnNeomakeJobFinished()
"     autocmd User NeomakeJobStarted call MyOnNeomakeJobStarted()
" augroup END
