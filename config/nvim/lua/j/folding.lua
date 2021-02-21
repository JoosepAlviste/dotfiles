local fn = vim.fn

local opt = require('j.utils').opt

local M = {}

function M.setup()
  local window = {vim.o, vim.wo}

  opt('foldmethod', 'expr', window)
  opt('foldexpr', 'nvim_treesitter#foldexpr()', window)
  opt('foldtext', 'v:lua.foldtext()', window)
  opt('foldlevelstart', 99)
end

local middot = '·'
local raquo = '»'
local small_l = 'ℓ'

function _G.foldtext()
  local indent_level = fn.indent(vim.v.foldstart)
  local indent = fn['repeat'](' ', indent_level - 2)
  local lines = '[' .. (vim.v.foldend - vim.v.foldstart + 1) .. small_l .. ']'
  local first = fn.substitute(fn.getline(vim.v.foldstart), '\\v\\s*', '', '')
  local dashes = fn.substitute(vim.v.folddashes, '-', middot, 'g')

  -- Add info about changed lines within the fold
  local before_lines = middot .. middot

  return indent .. raquo .. ' ' .. first .. ' ' .. before_lines .. lines .. dashes
end

return M
