local fn = vim.fn
local opt = vim.opt

function _G.foldtext()
  local indent_level = fn.indent(vim.v.foldstart)
  local indent = fn['repeat'](' ', indent_level)
  local first = fn.substitute(fn.getline(vim.v.foldstart), '\\v\\s*', '', '')

  return indent .. first .. '...' .. fn.getline(vim.v.foldend):gsub('^%s*', '')
end

opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldtext = 'v:lua.foldtext()'
opt.foldlevelstart = 99
