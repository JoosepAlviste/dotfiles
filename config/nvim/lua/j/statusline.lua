local M = {}

---@return integer
local function get_current_bufnr()
  return vim.fn.winbufnr(vim.g.statusline_winid) or 0
end

---Output the content colored by the supplied highlight group.
---@param highlight_group string
---@param content string
---@return string
local function color(highlight_group, content)
  return string.format('%%#%s#%s%%*', highlight_group, content)
end

---@return string
local function file_name()
  local file_path = '%{expand("%:p:h:t")}/%{expand("%:p:t")}'

  return file_path
end

local function file_modified()
  local is_modified = vim.api.nvim_get_option_value('modified', { buf = get_current_bufnr() })

  if is_modified then
    return color('StatuslineBoolean', '+')
  end

  return nil
end

local function file_read_only()
  local is_readonly = vim.api.nvim_get_option_value('readonly', { buf = get_current_bufnr() })

  if is_readonly then
    return color('StatuslineBoolean', '‼')
  end

  return nil
end

local function lsp_status()
  local bufnr = get_current_bufnr()

  local errors = vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
  local warnings = vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })

  local messages = {}
  if #errors ~= 0 then
    table.insert(messages, color('StatuslineError', string.format('E%s', #errors)))
  end
  if #warnings ~= 0 then
    table.insert(messages, color('StatuslineWarning', string.format('W%s', #warnings)))
  end

  return table.concat(messages, ' ')
end

function M.statusline()
  local sections = {
    ' ',
    file_name(),
    file_modified(),
    file_read_only(),
    -- Right side
    '%=',
    lsp_status(),
    ' ',
  }

  return table.concat(
    vim.tbl_filter(function(section)
      return section
    end, sections),
    ' '
  )
end

vim.o.statusline = [[%!v:lua.require('j.statusline').statusline()]]

return M
