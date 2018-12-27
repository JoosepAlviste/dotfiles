"
" Options
"

" The default of 31 is just a little too narrow.
let g:NERDTreeWinSize=40

" Disable display of '?' text and 'Bookmarks' label.
let g:NERDTreeMinimalUI=1

" Close NERDTree when it is the only open pane
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"
" Mappings
"

" Toggle NERDTree with a shortcut
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

