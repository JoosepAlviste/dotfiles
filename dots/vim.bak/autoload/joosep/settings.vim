scriptencoding utf-8

let s:middot='·'
let s:raquo='»'
let s:small_l='ℓ'

" Override default `foldtext()`, which produces something like:
"
"   +---  2 lines: source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim--------------------------------
"
" Instead returning:
"
"   »··[2ℓ]··: source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim···································
"
" Copied from https://github.com/wincent/wincent/blob/fd509b366f3bf1f8bef13e677e54f38d5ffe584b/roles/dotfiles/files/.vim/autoload/wincent/settings.vim
"
function! joosep#settings#foldtext() abort
    let l:lines='[' . (v:foldend - v:foldstart + 1) . s:small_l . ']'
    let l:first=substitute(getline(v:foldstart), '\v *', '', '')
    let l:dashes=substitute(v:folddashes, '-', s:middot, 'g')
    return s:raquo . s:middot . s:middot . l:lines . l:dashes . ': ' . l:first
endfunction

