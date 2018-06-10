" Do not show the status bar in the fzf window
set laststatus=0 
set noshowmode 
set noruler

" Show the status bar when the buffer gets closed
autocmd BufLeave <buffer> set laststatus=2 showmode ruler

