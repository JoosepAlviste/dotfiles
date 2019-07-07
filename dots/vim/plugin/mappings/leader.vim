"
" Leader mappings
"

" Open last buffer
nnoremap <leader><leader> <C-^>

" Quit the pane/buffer with <leader>q
nnoremap <silent> <leader>q :quit<cr>
" Save with <leader>w
nnoremap <silent> <leader>w :w!<cr>

nnoremap <leader>e :e <C-R>=substitute(expand('%:p:h').'/', getcwd().'/', '', '')<cr>

nnoremap <silent> <leader>/ za

" Useful mappings for managing tabs
noremap <silent> <leader>tn :tabnew<cr>
noremap <silent> <leader>to :tabonly<cr>
noremap <silent> <leader>tc :tabclose<cr>
noremap <silent> <leader>tm :tabmove<cr>
noremap <silent> <leader>t<leader> :tabnext<cr>

" Show relative filename
nnoremap <leader>k :echo @%<cr>

nnoremap <leader>o :only<cr>

function! s:editConfig()
    " Open the vimrc in a split
    vsplit $MYVIMRC
    " And set the working directory in that split to ~/dotfiles
    " TODO: Currently hard coded, would be nice if it weren't
    execute 'lcd ' . $HOME . '/dotfiles'
endfunction

" Edit and source the configuration file
nnoremap <silent> <leader>ev :call <sid>editConfig()<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>
