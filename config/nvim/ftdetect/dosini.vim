augroup detectDosINIFiletype
  autocmd!
  " .flowconfig files are most similar to dosini files
  autocmd BufRead,BufNewFile .flowconfig setfiletype dosini
augroup END
