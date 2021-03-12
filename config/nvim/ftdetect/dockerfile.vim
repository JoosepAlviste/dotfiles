augroup detectDockerfileFiletype
    autocmd!
    autocmd BufRead,BufNewFile Dockerfile-* setfiletype dockerfile
augroup END
