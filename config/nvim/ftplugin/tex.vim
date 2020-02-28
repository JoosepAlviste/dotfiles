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
