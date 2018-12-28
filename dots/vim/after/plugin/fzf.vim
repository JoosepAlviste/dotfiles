"
" Options
"

" Jump to existing window if possible
let g:fzf_buffers_jump = 1

" Customize colors to match the color scheme
let g:fzf_colors = { 
        \ 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'border':  ['fg', 'Ignore'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'], }

" Show file preview while grepping through files in fullscreen (Ag!). Or if ? is
" pressed,  then show small preview on the right.
command! -bang -nargs=* Ag
        \ call fzf#vim#ag(<q-args>,
        \                 <bang>0 ? fzf#vim#with_preview('up:60%')
        \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
        \                 <bang>0)

"
" Mappings
" 

nnoremap <silent> <leader>o :FZF<cr>
nnoremap <silent> <leader>t :Tags<cr>
nnoremap <silent> <leader>f :Lines<cr>
nnoremap <silent> <leader>ff :Ag!<cr>

