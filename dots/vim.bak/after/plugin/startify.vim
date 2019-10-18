"
" Settings
"

" Set bookmarks
let g:startify_bookmarks = [
            \ { 'd': '~/dotfiles/' },
            \ { 'b': '~/.config/surfraw/bookmarks' },
            \ ]

" Change directory to git root on item select
let g:startify_change_to_vcs_root = 1

" Better looking dialog box for cowsay
let g:startify_custom_header =
            \ startify#fortune#cowsay('', '─', '│', '┌', '┐', '┘', '└')

" Show DevIcons in the list of files
function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
