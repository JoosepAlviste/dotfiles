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
nnoremap <silent> <Left> :call joosep#quickfixed#older()<CR>
nnoremap <silent> <Right> :call joosep#quickfixed#newer()<CR>

" And shift + arrow keys for moving in the location list
nnoremap <silent> <S-Up> :lprevious<cr>
nnoremap <silent> <S-Down> :lnext<cr>

" Show syntax group under cursor
nnoremap <silent> <F10> :call joosep#syntax#SynStack()<cr>
nnoremap <silent> <F9> :call joosep#syntax#MoreSyntaxes()<cr>

" Always search forward with n and center afterwards
nnoremap <expr> n 'Nn'[v:searchforward] . 'zz'
xnoremap <expr> n 'Nn'[v:searchforward] . 'zz'
onoremap <expr> n 'Nn'[v:searchforward] . 'zz'

" And backwards with N and center afterwards
nnoremap <expr> N 'nN'[v:searchforward] . 'zz'
xnoremap <expr> N 'nN'[v:searchforward] . 'zz'
onoremap <expr> N 'nN'[v:searchforward] . 'zz'

" Make many of the jump commands also center on search term
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz
nnoremap * *zz
nnoremap # #zz

" Move current line
nnoremap [e :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e :<c-u>execute 'move +'. v:count1<cr>

" Insert empty lines above/below
nnoremap [<space> :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space> :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Ex-mode is weird and not useful so it seems better to repeat the last macro
nnoremap Q @@

" Split line with S
nnoremap S :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==^<CR>
