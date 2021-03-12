augroup detectGraphQLFiletype
    autocmd!
    autocmd BufRead,BufNewFile *.graphql setfiletype graphql
    " .prisma files are also GraphQL files
    autocmd BufRead,BufNewFile *.prisma setfiletype graphql
augroup END
