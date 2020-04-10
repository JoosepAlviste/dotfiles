scriptencoding utf-8

let s:middot='·'
let s:raquo='»'
let s:small_l='ℓ'

" Override default `foldtext()`.
"
" Taken from 
" https://github.com/wincent/wincent/blob/df584c66f292d3416b1841b6a36449d50c4a166e/roles/dotfiles/files/.vim/autoload/wincent/settings.vim
"
function! joosep#settings#foldtext() abort
  let indent_level = indent(v:foldstart)
  let indent = repeat(' ',indent_level)
  let l:lines='[' . (v:foldend - v:foldstart + 1) . s:small_l . ']'
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  let l:dashes=substitute(v:folddashes, '-', s:middot, 'g')
  return indent . s:raquo . ' ' . l:first . ' ' . s:middot . s:middot . l:lines . l:dashes
endfunction
