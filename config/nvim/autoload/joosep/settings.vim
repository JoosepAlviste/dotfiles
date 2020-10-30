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
  let indent = repeat(' ',indent_level - 2)
  let l:lines = '[' . (v:foldend - v:foldstart + 1) . s:small_l . ']'
  let l:first = substitute(getline(v:foldstart), '\v *', '', '')
  let l:dashes = substitute(v:folddashes, '-', s:middot, 'g')

  " Add info about changed lines within the fold
  let l:before_lines = s:middot .. s:middot
  let l:changed = gitgutter#fold#is_changed()
  if l:changed > 0
    let l:before_lines = l:before_lines .. '(*)' .. s:middot
  endif

  return indent . s:raquo . ' ' . l:first . ' ' . l:before_lines . l:lines . l:dashes
endfunction

let s:loaded_conf = 0
let s:conf = {
      \ 'flow.enabled': v:false,
      \ 'tsserver.enabled': v:true,
      \ 'python.prospector.args': '',
      \ 'python.autoComplete.extraPaths': [],
      \ }

" It is possible to create a file in `.vim/vim-settings.json` which can be 
" used to configure some things per-project. For example, which LSP settings 
" to use or which linter settings to use. The format of the file can be seen 
" from the default configuration in `s:conf`.
function! joosep#settings#get_conf() abort
  if s:loaded_conf
    return s:conf
  endif

  let l:settings_file_name = '.vim/vim-settings.json'
  if !file_readable(l:settings_file_name)
    let s:loaded_conf = 1
    return s:conf
  endif

  let l:settings = json_decode(readfile(l:settings_file_name))
  call extend(s:conf, l:settings, 'force')

  let s:loaded_conf = 1
  return s:conf
endfunction
