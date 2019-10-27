"
" Options
"

" Disable display of '?' text and 'Bookmarks' label.
let g:NERDTreeMinimalUI = 1

" When hitting "-", can hit C-^ to return to file
let g:NERDTreeCreatePrefix = 'silent keepalt keepjumps'

" Show hidden files/directories by default
let g:NERDTreeShowHidden = 1

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = [
            \ '^\.DS_Store$', '^tags$', '^tags.temp$', '^tags.lock$', 
            \ '\.git$[[dir]]', '\.idea$[[dir]]', '^tmux-client-.*\.log',
            \ '\.vscode$[[dir]]', '__pycache__$[[dir]]',
            \ '.pytest_cache$[[dir]]', '.pyc$', '.mypy_cache$[[dir]]',
            \ ]

" Automatically close NERDTree when a file is opened/selected
let NERDTreeQuitOnOpen = 1

" Automatically delete buffer after deleting file
let NERDTreeAutoDeleteBuffer = 1

" Make arrows invisible & make directories look better
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let g:DevIconsEnableFoldersOpenClose = 1

" Remove some unneeded padding from DevIcons glyphs
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''

"
" nerdtree-syntax-highlight
" Provide highlighting for the dev icons
"

" Helpful colors copied from nerdtree-syntax-highlight
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

" Disable everything by default, it is too darn laggy
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
" Enable just these default extensions
let g:NERDTreeSyntaxEnabledExtensions = [
      \ 'ts', 'json', 'md', 'js', 'css', 'html', 'png', 'py',
      \ ]

" Custom highlights
let g:NERDTreeExtensionHighlightColor = {
      \ 'tsx': s:blue,
      \ 'yml': s:red,
      \ }
let g:NERDTreeExactMatchHighlightColor = {
      \ '.gitignore': s:git_orange,
      \ '.gitattributes': s:git_orange,
      \ '.prettierrc': s:yellow,
      \ '.gitlab-ci.yml': s:orange,
      \ '.dockerignore': s:blue,
      \ 'yarn.lock': s:yellow,
      \ '.babelrc': s:yellow,
      \ 'package.json': s:green,
      \ }
let g:NERDTreePatternMatchHighlightColor = {
      \ 'docker-compose.*\.yml$': s:blue,
      \ '^dockerfile': s:blue,
      \ }


"
" Autocommands
"

" Select last file when opening NERDTree
if has('autocmd')
    augroup JoosepNERDTree
        autocmd!
        autocmd User NERDTreeInit call joosep#autocmds#attempt_select_last_file()
        " Close NERDTree when it is the only open pane
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    augroup END
endif


"
" Mappings
"

" Toggle NERDTree with a shortcut
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

" Like vim-vinegar, open the current directory when pressing "-"
nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>
