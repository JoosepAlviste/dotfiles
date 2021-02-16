augroup GitGutterAutocmds
  autocmd!

  " Disable gitgutter's default refresh behavior
  autocmd! gitgutter CursorHold,CursorHoldI
  " Refresh gitgutter when the file is saved
  autocmd BufWritePost * GitGutter
  " Refresh gitgutter after the buffer has been formatted
  autocmd User FormatterPost GitGutter
augroup END
