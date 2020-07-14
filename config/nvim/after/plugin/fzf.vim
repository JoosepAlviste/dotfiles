"
" Settings
"

" Jump to existing window if possible
let g:fzf_buffers_jump = 1

" Customize colors to match the color scheme
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Function'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Keyword'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Keyword'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'], }

let g:fzf_history_dir = '~/.local/share/fzf-history'
let $FZF_DEFAULT_OPTS='--layout=reverse'

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8, 'highlight': 'CursorLineNr', 'rounded': v:true } }


"
" Commands
"

" Show file preview while grepping through files in fullscreen. Or if ? is 
" pressed, then show small preview on the right.
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
      \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
      \   <bang>0)

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang Directories call fzf#run(fzf#wrap({'source': 'fd --type d'}))

command! -bang CWDHistory call fzf#run(fzf#wrap({
  \ 'source': s:DirectoryHistory(),
  \ 'options': [
  \   '--prompt', 'CWDHistory> ',
  \   '--multi',
  \ ]}, <bang>0)) 


"
" Mappings
"

" Working directory files
nnoremap <silent> <C-p> :FZF<cr>
" Current file's directory files
nnoremap <silent> <leader>- :FZF <c-r>=fnameescape(expand('%:p:h'))<cr>/<cr>
nnoremap <silent> <leader>ft :Tags!<cr>
" Lines in all buffers
nnoremap <silent> <leader>/ :Lines!<cr>
" All lines in all files in the project
nnoremap <silent> <leader>ff :Rg!<cr>
" Buffers
nnoremap <silent> <leader>b :Buffer<cr>
nnoremap <silent> <C-b> :Buffer<cr>
" Vim file editing history
nnoremap <silent> <leader>fr :CWDHistory<cr>
nnoremap <silent> <leader>fh :Helptags<cr>
" Commands history
nnoremap <silent> <leader>f: :History:<cr>
" Search history
nnoremap <silent> <leader>f/ :History/<cr>
" Commit history
nnoremap <silent> <leader>fc :Commits!<cr>
" All commands
nnoremap <silent> <leader>fa :Commands<cr>
nnoremap <silent> <leader>fx :GFiles!?<cr>

nnoremap <leader>fg :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>fg :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
  " Save previously copied text
  let saved_unnamed_register = @@

  " Copy the motion-ed or visually selected text
  if a:type ==# 'v'
    execute 'normal! `<v`>y'
  elseif a:type ==# 'char'
    execute 'normal! `[v`]y'
  else
    return
  endif

  " Open Ripgrep search with the term
  silent execute 'Rg! ' . @@

  " Restore previously copied text
  let @@ = saved_unnamed_register
endfunction

function! s:DirectoryHistory()
  return fzf#vim#_uniq(map(
    \ filter([expand('%')], 'len(v:val)')
    \   + filter(map(s:buflisted_sorted(), 'bufname(v:val)'), 'len(v:val)')
    \   + filter(copy(v:oldfiles), "s:FileIsInCWD(fnamemodify(v:val, ':p'))"),
    \ 'fnamemodify(v:val, ":~:.")'))
endfunction 

function! s:FileIsInCWD(file)
  return filereadable(a:file) && match(a:file, getcwd() . '/') == 0
endfunction 


"
" Statusline in FZF window
"

function! s:FzfStatusline()
  setlocal statusline=%#StatuslineAccent#\ »\ %*fzf%#StatuslineAccent#\ «%*%=%{getcwd()}\ 
endfunction

autocmd! User FzfStatusLine call <SID>FzfStatusline()


"
" Script functions copied from fzf.vim to make things work
"

function! s:buflisted_sorted()
  return sort(s:buflisted(), 's:sort_buffers')
endfunction

function! s:sort_buffers(...)
  let [b1, b2] = map(copy(a:000), 'get(g:fzf#vim#buffers, v:val, v:val)')
  " Using minus between a float and a number in a sort function causes an error
  return b1 < b2 ? 1 : -1
endfunction

function! s:buflisted()
  return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
endfunction 
