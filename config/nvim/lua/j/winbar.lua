local group = vim.api.nvim_create_augroup('Winbar', {})

local M = {}

M.set_winbar = function()
  local bufnum = vim.fn.winbufnr(vim.fn.winnr())
  local filetype = vim.fn.getbufvar(bufnum, '&filetype')

  if filetype ~= 'lir' then
    vim.opt_local.winbar = nil
  else
    vim.opt_local.winbar = vim.fn.expand('%')
      :gsub(vim.pesc(vim.loop.cwd()), '.')
      :gsub(vim.pesc(vim.fn.expand '$HOME'), '~')
  end
end

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
  group = group,
  callback = M.set_winbar,
})

return M
