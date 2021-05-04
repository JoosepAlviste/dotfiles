-- Utility commands for reloading the configuration and restarting LSP
vim.cmd [[command! Restart lua require'j.utils'.restart()]]
vim.cmd [[command! Reload lua require'j.utils'.reload()]]
