vim.cmd [[command! -nargs=1 NewFile call joosep#filesystem#create_file_or_folder(<f-args>)]]
vim.cmd [[command! -nargs=+ Move call joosep#filesystem#move(<f-args>)]]
