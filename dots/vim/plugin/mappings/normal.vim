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
nnoremap <silent> <Left> :cpfile<cr>
nnoremap <silent> <Right> :cnfile<cr>

" And shift + arrow keys for moving in the location list
nnoremap <silent> <S-Up> :lprevious<cr>
nnoremap <silent> <S-Down> :lnext<cr>
nnoremap <silent> <S-Left> :lpfile<cr>
nnoremap <silent> <S-Right> :lnfile<cr>

" Show syntax group under cursor
nnoremap <silent> <F10> :call joosep#syntax#SynStack()<cr>
" nnoremap <silent> <F10> :call joosep#syntax#MoreSyntaxes()<cr>

" Always search forward with n
nnoremap <expr> n 'Nn'[v:searchforward]
xnoremap <expr> n 'Nn'[v:searchforward]
onoremap <expr> n 'Nn'[v:searchforward]

" And backwards with N
nnoremap <expr> N 'nN'[v:searchforward]
xnoremap <expr> N 'nN'[v:searchforward]
onoremap <expr> N 'nN'[v:searchforward]

" Move current line
nnoremap [e :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e :<c-u>execute 'move +'. v:count1<cr>

" Insert empty lines above/below
nnoremap [<space> :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space> :<c-u>put =repeat(nr2char(10), v:count1)<cr>
