"
" Normal mode mappings
"

" Better pane movements
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'

" Yank from the cursor to the end of the line, like C and D
nnoremap Y y$

" Faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" More comfortable jumping to marks
nnoremap ' `
nnoremap ` '

" Show syntax group under cursor
nnoremap <silent> <F10> :call joosep#syntax#SynStack()<CR>
" nnoremap <silent> <F10> :call joosep#syntax#MoreSyntaxes()<CR>
