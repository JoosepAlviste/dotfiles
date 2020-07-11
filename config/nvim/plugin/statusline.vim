"
" My custom statusline with lots of help from 
" https://jip.dev/posts/a-simpler-vim-statusline/
"

function! s:RefreshStatusline()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
  endfor
endfunction

augroup MyStatusline
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatusline()
augroup END

function! s:LspStatus() abort
 let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []

  if get(info, 'error', 0)
    call add(msgs, <SID>Color(1, 'StatuslineError', 'E' . info['error']))
  endif

  if get(info, 'warning', 0)
    call add(msgs, <SID>Color(1, 'StatuslineWarning', 'W' . info['warning']))
  endif

  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

" This function just outputs the content colored by the supplied colorgroup 
" number, e.g. num = 2 -> User2 it only colors the input if the window is the 
" currently focused one
function! s:Color(active, num, content)
  if a:active
    return '%#' . a:num . '#' . a:content . '%*'
  else
    return a:content
  endif
endfunction

function! Status(winnum)
  let active = a:winnum == winnr()
  let bufnum = winbufnr(a:winnum)

  let type = getbufvar(bufnum, '&buftype')
  let name = bufname(bufnum)

  let stat = ''

  " File name
  let stat .= <SID>Color(active, 'StatuslineAccent', active ? ' »' : ' «')
  let stat .= ' %<'
  let stat .= '%{expand("%:p:h:t")}/%{expand("%:p:t")}'
  let stat .= ' ' . <SID>Color(active, 'StatuslineAccent', active ? '«' : '»')

  " File modified
  let modified = getbufvar(bufnum, '&modified')
  let stat .= <SID>Color(active, 'StatuslineBoolean', modified ? ' +' : '')

  " Read only
  let readonly = getbufvar(bufnum, '&readonly')
  let stat .= <SID>Color(active, 'StatuslineBoolean', readonly ? ' ‼' : '')

  " Paste
  if active && &paste
    let stat .= <SID>Color(active, 'StatuslineBoolean', ' P')
  endif

  " Right side
  let stat .= '%='

  " LSP & ALE status
  if active
    let stat .= <SID>LspStatus() .. '  '
  endif

  return stat
endfunction
