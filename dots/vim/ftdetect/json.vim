augroup detectJSONFiletype
    autocmd!
    " .prisma files are also GraphQL files
    autocmd BufRead,BufNewFile *.babelrc setfiletype json
augroup END
