"
" Options
"

" Sort directories first
let g:dirvish_mode = ':sort ,^.*[\/], '
" Ignore turds left behind by macOS, Git, and a few other things
let g:dirvish_hidden_files = [
      \ 'tags', '\.git\/', '\.DS_Store', '\.localized',
      \ ]
let g:dirvish_mode .= '| silent keeppatterns g/\v\/(' . join(g:dirvish_hidden_files, '|') . ')/d _'

" Git-specifics
let g:dirvish_git_show_ignored = 1
let g:dirvish_git_show_icons = 0


"
" Mappings
"

" Open a Dirvish split on the left side
nnoremap <silent> <C-n> :leftabove 40vsplit \| silent Dirvish<cr>


"
" Commands
"

" Replace the netrw commands with Dirvish specifics
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
