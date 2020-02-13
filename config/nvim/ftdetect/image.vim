augroup detectImageFiletype
    autocmd!
    autocmd BufRead,BufNewFile *.png setfiletype image
    autocmd BufRead,BufNewFile *.jpg setfiletype image
    autocmd BufRead,BufNewFile *.jpeg setfiletype image
    autocmd BufRead,BufNewFile *.gif setfiletype image
augroup END
