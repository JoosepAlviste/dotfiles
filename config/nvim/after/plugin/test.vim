"
" Settings
"

let g:test#strategy = 'neomake'
" Use the jest-vim-reporter (`yarn global add jest-vim-reporter`) and modify 
" this path if necessary (check `yarn global dir`)
let g:test#javascript#jest#options = '--reporters ' . $HOME . '/.local/share/yarn/global/node_modules/jest-vim-reporter'


"
" Mappings
"

nnoremap <silent> <leader>tn :TestNearest<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>tl :TestLast<cr>
nnoremap <silent> <leader>ta :TestSuite<cr>
nnoremap <silent> <leader>tv :TestVisit<cr>
