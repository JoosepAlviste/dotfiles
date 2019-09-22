let g:test#strategy = 'neomake'

let g:test#javascript#jest#options = '--reporters ' . $HOME . '/.config/yarn/global/node_modules/jest-vim-reporter'

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
