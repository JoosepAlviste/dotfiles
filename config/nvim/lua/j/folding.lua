local fn = vim.fn
local opt = vim.opt

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

opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldtext = 'v:lua.foldtext()'
opt.foldlevelstart = 99
