local group = vim.api.nvim_create_augroup('Winbar', {})

local M = {}

M.set_winbar = function()
  local bufnum = vim.fn.winbufnr(vim.fn.winnr())
  local filetype = vim.fn.getbufvar(bufnum, '&filetype')

  if filetype ~= 'lir' then
    vim.opt_local.winbar = nil
  else
    local folder_name = vim.fn.expand('%:p')
      :gsub(vim.pesc(vim.loop.cwd() .. '/'), '')
      :gsub(vim.pesc(vim.fn.expand '$HOME'), '~')

    if #folder_name > 0 then
      vim.opt_local.winbar = folder_name
    else
      vim.opt_local.winbar = vim.fn.expand('%:p'):gsub(vim.pesc(vim.fn.expand '$HOME'), '~')
    end
  end
end

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
  group = group,
  callback = M.set_winbar,
})

return M
