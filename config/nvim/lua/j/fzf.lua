local fzf = require('fzf')

local utils = require('j.utils')
local map = utils.map

local M = {}

function M.setup()
  map('n', '<c-p>', [[<cmd>lua require('fzf-commands').files()<cr>]])
end

function M.files()
  coroutine.wrap(function()
    local result = fzf.fzf({'choice 1', 'choice 2'}, '--ansi')  
    -- result is a list of lines that fzf returns, if the user has chosen
    if result then
      print(result[1])
    end
  end)()
end

return M
