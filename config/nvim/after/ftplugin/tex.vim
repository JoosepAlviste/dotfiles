if has('syntax')
  setlocal spell
endif

setlocal textwidth=80

" Autoformatting
setlocal formatoptions-=c

setlocal conceallevel=1

" Correct the last spelling error to the first option
inoremap <buffer> <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

nnoremap <buffer> <silent> go :VimtexView<cr>

nnoremap <buffer> <silent> <c-t> :call vimtex#fzf#run('ctli', g:fzf_layout)<cr>

" Continue lists when pressing creating a new line with `o`, `O` or `<cr>`
function! AddItem()
  let [end_lnum, end_col] = searchpairpos('\\begin{', '', '\\end{', 'nW')
  if match(getline(end_lnum), '\(itemize\|enumerate\|description\)') != -1
    return "\\item "
  else
    return ""
  endif
endfunction
imap <buffer><expr> <CR> getline('.') =~ '\item $' 
  \ ? '<c-w><c-w>' 
  \ : (col(".") < col("$") ? "\<Plug>(PearTreeExpand)" : "\<Plug>(PearTreeExpand)" .AddItem() )
nnoremap <expr><buffer> o "o".AddItem()
nnoremap <expr><buffer> O "O".AddItem()
