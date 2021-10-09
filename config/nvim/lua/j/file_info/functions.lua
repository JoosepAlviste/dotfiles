local api = vim.api

local TOP_MARGIN = 2
local RIGHT_MARGIN = 2

local M = {}

-- Show a simple popup with some basic file information
function M.file_info()
  local width = api.nvim_get_option 'columns'

  local filename = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
  local type = vim.bo.ft
  local branch = vim.b.gitsigns_head
  local lsp_client_names = table.concat(
    vim.tbl_map(function(client)
      return client.name
    end, vim.tbl_values(vim.lsp.buf_get_clients(0))),
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

  -- Pad labels of lines and convert each line to a string
  local lines_texts = vim.tbl_map(function(line)
    local label = line[1]
    local text = line[2]

    local padding = ''
    local nr_of_spaces_to_add = max_label_length - #label
    for i = 1, nr_of_spaces_to_add do
      padding = padding .. ' '
    end

    return label .. ': ' .. padding .. text
  end, lines)

  -- The popup should be as wide as the length of the longest line
  local line_lengths = vim.tbl_map(function(line)
    return #line
  end, lines_texts)
  local max_line_length = math.max(unpack(line_lengths))

  require('ui.popup').create(lines_texts, {
    col = width - RIGHT_MARGIN - max_line_length - 2,
    line = TOP_MARGIN,
    enter = false,
    time = 3000,
    padding = { 0, 1, 0, 1 },
  })
end

return M
