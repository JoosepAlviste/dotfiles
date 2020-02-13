let g:terminal_default_mapping = 0
let g:terminal_shell = 'zsh'

if joosep#getEnv() =~# 'DARWIN'
  " Set <M-=> to toggle the terminal but macOS alt (option) key is weird
  nnoremap <silent> ≠ :call TerminalToggle()<cr>
  if has('nvim') == 1
    " And to close the terminal (even in Terminal's 'INSERT' mode)
    tnoremap <silent> ≠ <c-\><c-n>:call TerminalToggle()<cr>
  else
    tnoremap <silent> ≠ <c-_>:call TerminalToggle()<cr>
  endif
elseif joosep#getEnv() =~# 'LINUX'
  " Set <M-=> to toggle the terminal in Linux -- it makes more sense!
  nnoremap <silent> <M-=> :call TerminalToggle()<cr>
  if has('nvim') == 1
    tnoremap <silent> <M-=> <c-\><c-n>:call TerminalToggle()<cr>
  else
    tnoremap <silent> <M-=> <c-_>:call TerminalToggle()<cr>
  endif
endif
