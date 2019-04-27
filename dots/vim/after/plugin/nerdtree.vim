"
" Options
"

" The default of 31 is just a little too narrow.
let g:NERDTreeWinSize=40

" Disable display of '?' text and 'Bookmarks' label.
let g:NERDTreeMinimalUI=1

" When hitting "-", can hit C-^ to return to file
let g:NERDTreeCreatePrefix='silent keepalt keepjumps'

" Close NERDTree when it is the only open pane
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Select last file when opening NERDTree
if has('autocmd')
    augroup JoosepNERDTree
        autocmd!
        autocmd User NERDTreeInit call joosep#autocmds#attempt_select_last_file()
    augroup END
endif


"
" Mappings
"

" Toggle NERDTree with a shortcut
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

" Like vim-vinegar, open the current directory when pressing "-"
nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>
