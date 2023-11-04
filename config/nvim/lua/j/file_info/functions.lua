local M = {}

local popup
local timer

-- Show a simple popup with some basic file information
function M.file_info()
  local Popup = require 'nui.popup'
  local NuiLine = require 'nui.line'
  local event = require('nui.utils.autocmd').event

  if popup then
    popup:unmount()
    popup = nil
  end
  if timer and not timer:is_closing() then
    timer:close()
  end

  local filename = vim
    .fn
    .expand('%')
    -- Remove CWD
    :gsub(vim.pesc(vim.loop.cwd()), '.')
    -- Remove home dir
    :gsub(vim.pesc(vim.fn.expand '$HOME'), '~')
    -- Remove leading ./
    :gsub('^%./', '')

  local type = vim.bo.ft
  local branch = vim.b.gitsigns_head
  local lsp_client_names = table.concat(
    vim.tbl_map(function(client)
      return client.name
    end, vim.tbl_values(vim.lsp.get_clients { bufnr = 0 })),
    ', '
  )

  -- Each line consists of a label and a text.
  local lines = { { 'name', filename } }
  if #type > 1 then
    table.insert(lines, { 'type', type })
  end
  if branch then
    table.insert(lines, { 'branch', branch })
  end
  if #lsp_client_names > 1 then
    table.insert(lines, { 'lsp', lsp_client_names })
  end

  local label_lengths = vim.tbl_map(function(line)
    return #line[1]
  end, lines)
  local max_label_length = math.max(unpack(label_lengths))

  -- Pad labels of lines and convert each line to a Nui Line object
  local nui_lines = vim.tbl_map(function(line)
    local label = line[1]
    local value = line[2]

    local padding = ''
    local nr_of_spaces_to_add = max_label_length - #label
    for _ = 1, nr_of_spaces_to_add do
      padding = padding .. ' '
    end

    local l = NuiLine()
    l:append(label .. ': ' .. padding, 'Function')
    l:append(value)

    return l
  end, lines)

  local max_line_length = 0
  for _, line in ipairs(nui_lines) do
    if #line:content() > max_line_length then
      max_line_length = #line:content()
    end
  end

  popup = Popup {
    enter = false,
    focusable = true,
    border = {
      style = 'rounded',
    },
    position = {
      row = '1',
      col = '100%',
    },
    size = {
      width = max_line_length,
      height = #nui_lines,
    },
  }

  popup:mount()

  popup:on(event.BufLeave, function()
    popup:unmount()
    popup = nil
  end)
  popup:on(event.BufEnter, function()
    if timer then
      timer:close()
    end
  end)

  for index, line in ipairs(nui_lines) do
    line:render(popup.bufnr, -1, index)
  end

  timer = vim.defer_fn(function()
    popup:unmount()
    popup = nil
  end, 7000)
end

return M
