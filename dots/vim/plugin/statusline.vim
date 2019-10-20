"
" My custom statusline with lots of help from 
" https://jip.dev/posts/a-simpler-vim-statusline/
"

function! s:RefreshStatusline()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
  endfor
endfunction

augroup myStatusline
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatusline()
augroup END

function! Status(winnum)
  let active = a:winnum == winnr()
  let bufnum = winbufnr(a:winnum)

  let type = getbufvar(bufnum, '&buftype')
  let name = bufname(bufnum)

  let stat = ''

  " This function just outputs the content colored by the supplied colorgroup 
  " number, e.g. num = 2 -> User2 it only colors the input if the window is 
  " the currently focused one
  function! Color(active, num, content)
    if a:active
      return '%#' . a:num . '#' . a:content . '%*'
    else
      return a:content
    endif
  endfunction

  " File name
  let stat .= Color(active, 'StatuslineAccent', active ? ' »' : ' «')
  let stat .= ' %<'
  " let stat .= '%f'
  let stat .= '%{expand("%:p:h:t")}/%{expand("%:p:t")}'
  let stat .= ' ' . Color(active, 'StatuslineAccent', active ? '«' : '»')

  " File modified
  let modified = getbufvar(bufnum, '&modified')
  let stat .= Color(active, 'StatuslineBoolean', modified ? ' +' : '')

  " Read only
  let readonly = getbufvar(bufnum, '&readonly')
  let stat .= Color(active, 'StatuslineBoolean', readonly ? ' ‼' : '')

  " Paste
  if active && &paste
    let stat .= Color(active, 'StatuslineBoolean', ' P')
  endif

  " Right side (currently empty)
  let stat .= '%='

  " CoC status
  let stat .= Color(active, 'Statusline', '%{coc#status()} ')

  return stat
endfunction
