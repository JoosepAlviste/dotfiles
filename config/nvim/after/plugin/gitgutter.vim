augroup GitGutterAutocmds
  autocmd!

  " Disable gitgutter's default refresh behavior
  autocmd! gitgutter CursorHold,CursorHoldI
  " Refresh gitgutter when the file is saved
  autocmd BufWritePost * GitGutter
augroup END
