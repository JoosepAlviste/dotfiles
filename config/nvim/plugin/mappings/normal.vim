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

" Repurpose arrow keys for quickfix list movement
nnoremap <silent> <Up> :cprevious<cr>
nnoremap <silent> <Down> :cnext<cr>

" And shift + arrow keys for moving in the location list
nnoremap <silent> <S-Up> :lprevious<cr>
nnoremap <silent> <S-Down> :lnext<cr>

" Show syntax group under cursor
nnoremap <silent> <F10> :call joosep#syntax#SynStack()<cr>
nnoremap <silent> <F9> :call joosep#syntax#MoreSyntaxes()<cr>

" Make many of the jump commands also center on search term
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" Ex-mode is weird and not useful so it seems better to repeat the last macro
nnoremap Q @@

" Split line with S
nnoremap <silent> S :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==^<CR>

" Open the file under the cursor with the default file handler for that file 
" type (e.g., Firefox for `http` links, etc.)
" This mapping normally comes from `netrw`, but since we disable that (for 
" dirvish), then we need to manually configure the mapping again
nnoremap <silent> gx :call system('open ' . expand('%'))<CR>
