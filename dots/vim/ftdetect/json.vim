augroup detectJSONFiletype
    autocmd!
    autocmd BufRead,BufNewFile *.babelrc setfiletype json
    autocmd BufRead,BufNewFile .eslintrc setfiletype json
    autocmd BufRead,BufNewFile .prettierrc setfiletype json
augroup END
