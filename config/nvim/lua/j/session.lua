local create_augroups = require('j.utils').create_augroups

local M = {}

function M.setup()
  vim.cmd [[set sessionoptions-=buffers]]
  vim.cmd [[set sessionoptions-=folds]]

  if vim.fn.argc() == 0 then
    create_augroups({
      session = {
        {'VimEnter', '*', 'nested', [[lua require('j.session').continue_session()]]},
      },
    })
  end
end

function M.continue_session()
  if vim.fn.filereadable('.vim/Session.vim') == 1 then
    vim.cmd [[source .vim/Session.vim]]
  end
end

return M
