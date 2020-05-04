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
            \ '\.netrwhist$',
            \ ]

" Automatically delete buffer after deleting file
let NERDTreeAutoDeleteBuffer = 1

" Make arrows invisible
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"

" Remove some unneeded padding from DevIcons glyphs
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''


"
" Autocommands
"

" Select last file when opening NERDTree
augroup JoosepNERDTree
  autocmd!
  autocmd User NERDTreeInit call joosep#autocmds#attempt_select_last_file()
  " Close NERDTree when it is the only open pane
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
augroup END


"
" Mappings
"

" Toggle NERDTree with a shortcut
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

" Like vim-vinegar, open the current directory when pressing "-"
nnoremap <silent><unique> <Plug>NERDTreeGoUp :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>
nmap <silent> - <Plug>NERDTreeGoUp


"
" NERDTree Git status plugin
"

let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeShowIgnoredStatus = 1

let s:colors = g:joosep#colors#material#GetColors()
let g:NERDTreeColorMapCustom = {
      \ 'Modified': s:colors.blue,
      \ 'Staged': s:colors.green,
      \ 'Untracked': s:colors.orange,
      \ 'Dirty': s:colors.purple,
      \ 'Clean': '#87939A',
      \ 'Ignored': s:colors.darker_fg,
      \ }
