augroup detectGraphQLFiletype
    autocmd!
    " .prisma files are also GraphQL files
    autocmd BufRead,BufNewFile *.prisma setfiletype graphql
augroup END
