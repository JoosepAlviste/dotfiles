local autopairs = require('nvim-autopairs')

local map = require('j.utils').map

local M = {}

function MUtils.confirm()
  if vim.fn.pumvisible() ~= 0  then
--     if vim.fn.complete_info()["selected"] ~= -1 then
--       vim.fn["compe#confirm"]()
--       return autopairs.esc("<c-y>")
--     else
--       vim.defer_fn(function()
--         vim.fn["compe#confirm"]("<cr>")
--       end, 20)
--       return autopairs.esc("<c-n>")
--     end
  else
    return autopairs.check_break_line_char()
  end
end

function M.setup()
  autopairs.setup()

  map('i', '<cr>', 'v:lua.MUtils.confirm()', {expr = true, noremap = true})
end

return M
