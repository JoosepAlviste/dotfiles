" Do not show the status bar in the fzf window
setlocal laststatus=0
setlocal noshowmode
setlocal noruler

setlocal nonumber
setlocal norelativenumber

" Show the status bar when the buffer gets closed
autocmd BufLeave <buffer> setlocal laststatus=2
