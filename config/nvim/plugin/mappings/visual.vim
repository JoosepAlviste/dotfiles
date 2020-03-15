"
" Visual mode mappings
"

" Better pane movements
vnoremap <C-h> <C-w>h
vnoremap <C-j> <C-w>j
vnoremap <C-k> <C-w>k
vnoremap <C-l> <C-w>l

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Copy to clipboard when selecting text with mouse
vnoremap <LeftRelease> "+y<LeftRelease>
