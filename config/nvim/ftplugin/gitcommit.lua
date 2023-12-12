local termcode = require('j.utils').termcode

-- Settings

-- No line numbers
vim.opt_local.relativenumber = false
vim.opt_local.number = false
vim.opt_local.signcolumn = 'no'

vim.opt_local.textwidth = 72
vim.opt_local.colorcolumn = { 73, 51 }

-- Autoformatting
-- Enable formatting everywhere, not just comments
vim.opt_local.formatoptions:append 'ca'

vim.opt_local.spell = true
vim.opt_local.iskeyword:remove '-'

-- Plugin settings

vim.b.EditorConfig_disable = 1

-- Mappings

-- Navigate between changed files
vim.keymap.set('n', '{', '?^@@<cr>', { silent = true, buffer = true })
vim.keymap.set('n', '}', '/^@@<cr>', { silent = true, buffer = true })

---@return string | nil
local function parse_issue_key()
  local branch = vim.fn.system 'git branch --show-current'
  if not branch then
    return nil
  end

  local pattern = '^/(%a+%-%d+).*$'
  local branch_without_prefix = branch:gsub('^feature', ''):gsub('^fix', '')
  local issue_key = branch_without_prefix:match(pattern)

  return issue_key
end

local function insert_issue_key()
  local lines = vim.fn.getline(1, '$')
  local is_empty_line = #lines and #lines[1] == 0
  if not is_empty_line then
    return
  end

  local issue_key = parse_issue_key()
  if issue_key then
    vim.api.nvim_feedkeys('o[' .. issue_key .. ']' .. termcode '<esc>' .. 'ggO', 'n', false)
  else
    vim.api.nvim_feedkeys('O', 'n', false)
  end
end

insert_issue_key()
