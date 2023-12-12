local group = vim.api.nvim_create_augroup('Setup', {})

-- Highlight text after yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  callback = function()
    require('vim.highlight').on_yank { higroup = 'Substitute', timeout = 200 }
  end,
})

-- Automatically close Vim if the quickfix window is the only one open
vim.api.nvim_create_autocmd('WinEnter', {
  group = group,
  callback = function()
    if vim.fn.winnr '$' == 1 and vim.fn.win_gettype() == 'quickfix' then
      vim.cmd.q()
    end
  end,
})
