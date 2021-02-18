local cmd = vim.cmd

local M = {}

function M.opt(o, v, scopes)
  scopes = scopes or {vim.o}
  v = v == nil and true or v

  if type(v) == 'table' then
    v = table.concat(v, ',')
  end

  for _, s in ipairs(scopes) do s[o] = v end
end

function M.map(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then modes = {modes} end
  for _, mode in ipairs(modes) do vim.api.nvim_set_keymap(mode, lhs, rhs, opts) end
end

function M.create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    cmd('augroup ' .. group_name)
    cmd('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      cmd(command)
    end
    cmd('augroup END')
  end
end

return M
