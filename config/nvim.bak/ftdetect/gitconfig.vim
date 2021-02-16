augroup detectGitConfigFiletype
    autocmd!
    autocmd BufRead,BufNewFile *config/git/config setfiletype gitconfig
augroup END
