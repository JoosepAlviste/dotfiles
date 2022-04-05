-- My minimal custom statusline with lots of help from
--   https://jip.dev/posts/a-simpler-vim-statusline/

local termcode = require('j.utils').termcode

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
  local errors = vim.diagnostic.get(0, { severity = 1 })
  local warnings = vim.diagnostic.get(0, { severity = 2 })

  local messages = {}
  if #errors ~= 0 then
    table.insert(messages, color(true, 'StatuslineError', 'E' .. #errors))
  end
  if #warnings ~= 0 then
    table.insert(messages, color(true, 'StatuslineWarning', 'W' .. #warnings))
  end

  return table.concat(messages, ' ')
end

local mode_colors = {
  n = 'Normal',
  i = 'Insert',
  R = 'Replace',
  v = 'Visual',
  V = 'Visual',
  [termcode '<c-v>'] = 'Visual',
  c = 'Command',

  s = 'Normal',
  S = 'Normal',
  [termcode '<c-s>'] = 'Normal',
  t = 'Normal',
}

function _G.statusline(winnr)
  local is_active = winnr == vim.fn.winnr()
  local bufnum = vim.fn.winbufnr(winnr)

  local mode = vim.fn.mode()
  local mode_color = 'Statusline' .. (mode_colors[mode] or 'Normal')

  local segments = {}

  -- File name
  local file_name = vim.fn.expand('#' .. bufnum .. ':p:t')
  local extension = vim.fn.expand('#' .. bufnum .. ':e')
  local icon, highlight = require('nvim-web-devicons').get_icon(file_name, extension)

  if not icon and #file_name == 0 then
    -- Is in a folder
    icon = ''
    highlight = 'Accent'
  end

  local file_path = '%{expand("%:p:h:t")}/%{expand("%:p:t")}'
  table.insert(segments, color(is_active, 'StatuslineAccent', is_active and '»' or '«'))
  table.insert(segments, '%<' .. file_path)
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

  local icon_statusline = color(is_active, 'Statusline' .. (highlight or 'Accent'), icon or '●') .. ' '
  return color(is_active, mode_color, '▎ ') .. icon_statusline .. '  ' .. table.concat(segments, ' ') .. '  '
end

local group = vim.api.nvim_create_augroup('Statusline', {})
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
  group = group,
  callback = function()
    vim.wo.statusline = '%!v:lua.statusline(' .. vim.fn.winnr() .. ')'
  end,
})

-- Use a global statusline for all windows
vim.opt.laststatus = 3
