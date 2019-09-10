"
" Options
"

" The default of 31 is just a little too narrow.
let g:NERDTreeWinSize = 35

" Disable display of '?' text and 'Bookmarks' label.
let g:NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" When hitting "-", can hit C-^ to return to file
let g:NERDTreeCreatePrefix = 'silent keepalt keepjumps'

" Show hidden files/directories by default
let g:NERDTreeShowHidden = 1

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = [
            \ '^\.DS_Store$', '^tags$', '^tags.temp$', '^tags.lock$', 
            \ '\.git$[[dir]]', '\.idea$[[dir]]', '^tmux-client-.*\.log',
            \ '\.vscode$[[dir]]',
            \ ]

" Automatically close NERDTree when a file is opened/selected
let NERDTreeQuitOnOpen = 1

" Automatically delete buffer after deleting file
let NERDTreeAutoDeleteBuffer = 1

" More minimal statusline in NERDTree
let NERDTreeStatusline="%8*%=%7*NERDTree%8*%="

" Select last file when opening NERDTree
if has('autocmd')
    augroup JoosepNERDTree
        autocmd!
        autocmd User NERDTreeInit call joosep#autocmds#attempt_select_last_file()
        " Close NERDTree when it is the only open pane
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    augroup END
endif


"
" Mappings
"

" Toggle NERDTree with a shortcut
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

" Like vim-vinegar, open the current directory when pressing "-"
nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>
