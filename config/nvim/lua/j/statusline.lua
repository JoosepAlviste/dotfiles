local create_augroups = require('j.utils').create_augroups

-- My minimal custom statusline with lots of help from 
-- https://jip.dev/posts/a-simpler-vim-statusline/

local M = {}

-- Output the content colored by the supplied highlight group. Only color the 
-- input if the window is the currently focused one.
local function color(active, highlight_group, content)
  if active then
    return '%#' .. highlight_group .. '#' .. content .. '%*'
  else
    return content
  end
end

-- Get the statusline segment showing the LSP diagnostics' count
local function lsp_status()
  local errors = vim.lsp.diagnostic.get_count(0, [[Error]])
  local warnings = vim.lsp.diagnostic.get_count(0, [[Warning]])

  local messages = {}
  if errors ~= 0 then
    table.insert(messages, color(true, 'StatuslineError', 'E' .. errors))
  end
  if warnings ~= 0 then
    table.insert(messages, color(true, 'StatuslineWarning', 'W' .. warnings))
  end

  return table.concat(messages, ' ')
end

function _G.statusline(winnr)
  local is_active = winnr == vim.fn.winnr()
  local bufnum = vim.fn.winbufnr(winnr)

  local segments = {}

  -- File name
  local file_name = vim.fn.expand('#' .. bufnum .. ':p:t')
  local extension = vim.fn.expand('#' .. bufnum .. ':e')
  local icon, highlight = require('nvim-web-devicons').get_icon(file_name, extension)

  local file_path = '%{expand("%:p:h:t")}/%{expand("%:p:t")}'
  table.insert(segments, color(is_active, 'StatuslineAccent', is_active and '»' or '«'))
  local icon_statusline = icon and color(is_active, 'Statusline' .. highlight, icon) .. ' ' or ''
  table.insert(segments, '%<' .. icon_statusline .. file_path)
  table.insert(segments, color(is_active, 'StatuslineAccent', is_active and '«' or '»'))

  -- File modified
  if vim.fn.getbufvar(bufnum, '&modified') == 1 then
    table.insert(segments, color(is_active, 'StatuslineBoolean', '+'))
  end

  -- Read only
  if vim.fn.getbufvar(bufnum, '&readonly') == 1 then
    table.insert(segments, color(is_active, 'StatuslineBoolean', '‼'))
  end

  -- Right side
  table.insert(segments, '%=')

  -- LSP diagnostics
  if is_active then
    table.insert(segments, lsp_status())
  end

  return '  ' .. table.concat(segments, ' ') .. '  '
end

function M.setup()
  create_augroups({
    statusline = {
      {'BufWinEnter,WinEnter', '*', [[lua vim.wo.statusline = '%!v:lua.statusline(' .. vim.fn.winnr() .. ')']]},
    },
  })
end

return M
