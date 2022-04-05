local group = vim.api.nvim_create_augroup('Terminal', {})
vim.api.nvim_create_autocmd('TermOpen', {
  group = group,
  callback = function()
    vim.cmd [[setlocal nonumber]]
    vim.cmd [[setlocal norelativenumber]]
    vim.cmd [[setlocal signcolumn=no]]

    vim.cmd [[setlocal nottimeout]]
    vim.cmd [[setlocal ttimeoutlen=10]]

    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<c-\><c-n>]], { noremap = true })
    vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<c-\><c-n>]], { noremap = true })
  end,
})
