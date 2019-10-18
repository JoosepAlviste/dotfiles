let g:test#strategy = 'neomake'

let g:test#javascript#jest#options = '--reporters ' . $HOME . '/.config/yarn/global/node_modules/jest-vim-reporter'

let g:root_markers = ['package.json', '.git/']
function! s:RunVimTest(cmd)
    for marker in g:root_markers
        let marker_file = findfile(marker, expand('%:p:h') . ';')
        if strlen(marker_file) > 0
            let g:test#project_root = fnamemodify(marker_file, ":p:h")
            break
        endif
        let marker_dir = finddir(marker, expand('%:p:h') . ';')
        if strlen(marker_dir) > 0
            let g:test#project_root = fnamemodify(marker_dir, ":p:h")
            break
        endif
    endfor

    execute a:cmd
endfunction

nnoremap <silent> <leader>tf :call <SID>RunVimTest('TestFile')<cr>
nnoremap <silent> <leader>tn :call <SID>RunVimTest('TestNearest')<cr>
nnoremap <silent> <leader>ts :call <SID>RunVimTest('TestSuite')<cr>
nnoremap <silent> <leader>tl :call <SID>RunVimTest('TestLast')<cr>
nnoremap <silent> <leader>tv :call <SID>RunVimTest('TestVisit')<cr>
