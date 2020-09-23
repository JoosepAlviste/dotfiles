function! joosep#session#continue_session() abort
  if filereadable('.vim/Session.vim')
    source .vim/Session.vim
  endif
endfunction
