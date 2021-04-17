vim.cmd [[command! -nargs=1 NewFile call joosep#filesystem#create_file_or_folder(<f-args>)]]
vim.cmd [[command! -nargs=+ Move call joosep#filesystem#move(<f-args>)]]

-- Utility commands for reloading the configuration and restarting LSP
vim.cmd [[command! Restart lua require'j.utils'.restart()]]
vim.cmd [[command! Reload lua require'j.utils'.reload()]]
