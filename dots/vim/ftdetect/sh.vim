augroup detectShFiletype
    autocmd!
    autocmd BufRead,BufNewFile .env* setfiletype sh
augroup END
