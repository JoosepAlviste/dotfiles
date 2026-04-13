---@class CursorAgent
---@field terminal_id string
---@field title string
---@field pid number

local kitty_socket = vim.env.KITTY_LISTEN_ON or 'unix:/tmp/kitty'

---@return string
local function get_project_root()
  local result = vim.system({ 'git', 'rev-parse', '--show-toplevel' }):wait()
  if result.code ~= 0 then
    return vim.fn.getcwd()
  end
  return (vim.trim(result.stdout))
end

---@param root string
---@return string
local function get_current_file_relative_path(root)
  return (vim.fn.expand('%:p'):gsub('^oil://', ''):gsub(vim.pesc(root .. '/'), ''))
end

---@param cwd string
---@return CursorAgent[]
local function kitty_get_agents(cwd)
  local result = vim.system({ 'kitty', '@', '--to', kitty_socket, 'ls' }):wait()
  if result.code ~= 0 then
    return {}
  end
  local ok, os_windows = pcall(vim.json.decode, result.stdout)
  if not ok then
    return {}
  end

  ---@type CursorAgent[]
  local agents = {}
  for _, os_window in ipairs(os_windows) do
    for _, tab in ipairs(os_window.tabs) do
      for _, window in ipairs(tab.windows) do
        for _, process in ipairs(window.foreground_processes) do
          if process.cmdline[1] and process.cmdline[1]:match 'agent$' and process.cwd == cwd then
            table.insert(agents, {
              terminal_id = tostring(window.id),
              title = window.title,
              pid = process.pid,
            })
          end
        end
      end
    end
  end

  return agents
end

---@param agent CursorAgent
---@param text string
local function kitty_send(agent, text)
  vim.system({ 'kitty', '@', '--to', kitty_socket, 'send-text', '--match', 'id:' .. agent.terminal_id, text }):wait()
  vim.system { 'kitty', '@', '--to', kitty_socket, 'focus-window', '--match', 'id:' .. agent.terminal_id }
end

---@param root string
---@param text string
local function send_to_cursor(root, text)
  local agents = kitty_get_agents(root)

  if #agents == 0 then
    vim.notify('No cursor agents found in ' .. root, vim.log.levels.WARN)
    return
  end

  if #agents == 1 then
    kitty_send(agents[1], text)
    return
  end

  vim.ui.select(agents, {
    prompt = 'Select cursor agent:',
    format_item = function(agent)
      return string.format('%s  %s', agent.terminal_id, agent.title)
    end,
  }, function(agent)
    if agent then
      kitty_send(agent, text)
    end
  end)
end

local severity_labels = { 'Error', 'Warning', 'Info', 'Hint' }

---@param diagnostics vim.Diagnostic[]
---@param file string
local function format_diagnostics(diagnostics, file)
  local parts = {}
  for _, d in ipairs(diagnostics) do
    local label = severity_labels[d.severity] or 'Unknown'
    local source = d.source and string.format(' (%s)', d.source) or ''
    table.insert(parts, string.format('%s:%d %s: %s%s', file, d.lnum + 1, label, d.message, source))
  end
  return parts
end

vim.api.nvim_create_user_command('LineToCursor', function(opts)
  local start_line = opts.line1
  local end_line = opts.line2
  local has_selection = opts.range == 2

  local root = get_project_root()
  local file = get_current_file_relative_path(root)

  local text = has_selection and string.format('%s:%d-%d ', file, start_line, end_line)
    or string.format('%s:%d ', file, start_line)

  send_to_cursor(root, text)
end, {
  range = true,
})

vim.api.nvim_create_user_command('DiagToCursor', function()
  local root = get_project_root()
  local file = get_current_file_relative_path(root)
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local diagnostics = vim.diagnostic.get(0, { lnum = line - 1 })

  if #diagnostics == 0 then
    vim.notify('No diagnostics on current line', vim.log.levels.WARN)
    return
  end

  send_to_cursor(root, table.concat(format_diagnostics(diagnostics, file), '\n') .. ' ')
end, {})

vim.api.nvim_create_user_command('FileDiagToCursor', function()
  local root = get_project_root()
  local file = get_current_file_relative_path(root)
  local diagnostics = vim.diagnostic.get(0)

  if #diagnostics == 0 then
    vim.notify('No diagnostics in ' .. file, vim.log.levels.WARN)
    return
  end

  send_to_cursor(root, table.concat(format_diagnostics(diagnostics, file), '\n') .. ' ')
end, {})

vim.keymap.set({ 'n', 'x' }, '<leader>ao', ':LineToCursor<cr>', { silent = true })
vim.keymap.set({ 'n', 'x' }, '<leader>ad', ':DiagToCursor<cr>', { silent = true })
vim.keymap.set({ 'n', 'x' }, '<leader>aD', ':FileDiagToCursor<cr>', { silent = true })
