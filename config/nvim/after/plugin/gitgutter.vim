function s:RefreshGitGutterAfterSave()
  " Do not refresh gitgutter for these files which will be autoformatted
  if &ft =~ 'typescript\|typescriptreact\|vue'
    return
  endif

  GitGutter
endfunction

augroup GitGutterAutocmds
  autocmd!

  " Disable gitgutter's default refresh behavior
  autocmd! gitgutter CursorHold,CursorHoldI
  " Refresh gitgutter when the file is saved
  autocmd BufWritePost * call s:RefreshGitGutterAfterSave()
  " Refresh gitgutter after the buffer has been formatted
  autocmd User FormatterPost GitGutter
augroup END
