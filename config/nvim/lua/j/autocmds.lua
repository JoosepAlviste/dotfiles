local group = vim.api.nvim_create_augroup('Setup', {})

-- Highlight text after yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  callback = function()
    require('vim.hl').on_yank { higroup = 'Substitute', timeout = 200 }
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

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Open file at the last position it was edited earlier',
  group = group,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})
