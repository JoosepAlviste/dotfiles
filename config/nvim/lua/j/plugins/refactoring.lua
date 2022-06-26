require('refactoring').setup {}

vim.keymap.set('v', '<leader>rf', [[<esc><cmd>lua require('refactoring').refactor('Extract Function')<cr>]])
vim.keymap.set('v', '<leader>rv', [[<esc><cmd>lua require('refactoring').refactor('Extract Variable')<cr>]])
vim.keymap.set('v', '<leader>ri', [[<esc><cmd>lua require('refactoring').refactor('Inline Variable')<cr>]])
vim.keymap.set('n', '<leader>ri', [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]])

vim.keymap.set('v', '<leader>rr', ":lua require('refactoring').select_refactor()<CR>")
vim.keymap.set('n', '<leader>rr', ":lua require('refactoring').select_refactor()<CR>")
