"
" Settings
"

if has('syntax')
  setlocal spell
endif

setlocal wrap
setlocal textwidth=80

" Disable some weird autoindenting
" https://github.com/plasticboy/vim-markdown/issues/126
setlocal indentexpr=


"
" Mappings
"

nnoremap <buffer> o A<cr>
nnoremap <buffer> O kA<cr>

function! s:HandleTab() abort
  if match(getline('.'), "\\s*[*\\-+]\\s") != -1
    return "\<esc>>>A"
  else
    return "\<tab>"
  endif
endfunction
inoremap <buffer> <expr> <tab> <SID>HandleTab()

function! s:HandleTabBack() abort
  if match(getline('.'), "\\s*[*\\-+]\\s") != -1
    return "\<esc><<A"
  else
    return "\<tab>"
  endif
endfunction
inoremap <buffer> <expr> <s-tab> <SID>HandleTabBack()
