require'compe'.setup {
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    ultisnips = true,
  },
}

-- Mappings

local opts = {noremap = true, expr = true, silent = true}
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', opts)
vim.api.nvim_set_keymap('i', '<c-e>', 'compe#close(\'<c-e>\')', opts)
vim.api.nvim_set_keymap('i', '<c-y>', 'compe#confirm(\'<c-y>\')', opts)
