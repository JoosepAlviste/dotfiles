" Sets only once the value of g:env to the running environment
" From https://vimways.org/2018/make-your-setup-truly-cross-platform/
function! joosep#getEnv() abort
  if exists('g:env')
    return g:env
  endif
  if has('win64') || has('win32') || has('win16')
    let g:env = 'WINDOWS'
  else
    let g:env = toupper(substitute(system('uname'), '\n', '', ''))
  endif
  return g:env
endfunction
