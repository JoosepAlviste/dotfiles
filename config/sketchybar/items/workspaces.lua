local colors = require 'colors'
local settings = require 'settings'
local app_icons = require 'app_icons'
local constants = require 'constants'

-- Add padding to the left
local root = sbar.add('item', constants.items.SPACES, {
  padding_left = 6,
  padding_right = 0,
})

local workspaces = {}

---@class WithWindowsCallbackArg
---@field open_windows table<string, string[]>
---@field focused_workspaces string[]
---@field visible_workspaces AerospaceWorkspace[]

---@class AerospaceWindow
---@field app-name string
---@field workspace string
---@field window-title string

---@class AerospaceWorkspace
---@field monitor-appkit-nsscreen-screens-id number
---@field workspace string

---@class AerospaceWorkspaceChangeEnv
---@field FOCUSED_WORKSPACE string

---@param callback fun(workspaces: AerospaceWorkspace[]): any
local function get_workspaces(callback)
  sbar.exec(
    "aerospace list-workspaces --all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json",
    ---@param workspaces_and_monitors AerospaceWorkspace[]
    function(workspaces_and_monitors)
      callback(workspaces_and_monitors)
    end
  )
end

---@param callback fun(workspace: string[]): any
local function get_focused_workspaces(callback)
  ---@param focused_workspace string[]
  sbar.exec('aerospace list-workspaces --focused', function(focused_workspace)
    callback(focused_workspace)
  end)
end

---@param callback fun(workspaces: AerospaceWorkspace[]): any
local function get_visible_workspaces(callback)
  sbar.exec(
    "aerospace list-workspaces --visible --monitor all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json",
    ---@param visible_workspaces AerospaceWorkspace[]
    function(visible_workspaces)
      callback(visible_workspaces)
    end
  )
end

---@param callback fun(windows: AerospaceWindow[]): any
local function get_windows(callback)
  sbar.exec(
    "aerospace list-windows --monitor all --format '%{workspace}%{app-name}%{window-title}' --json",
    ---@param workspace_and_windows AerospaceWindow[]
    function(workspace_and_windows)
      ---It can happen that closed windows are still returned with "window-title = ''"
      ---We don't want to show these windows in the bar since they aren't actually focusable.
      ---@type AerospaceWindow[]
      local windows_with_title = {}
      for _, window in ipairs(workspace_and_windows) do
        if #window['window-title'] > 0 then
          table.insert(windows_with_title, window)
        end
      end

      callback(windows_with_title)
    end
  )
end

---@param callback fun(args: WithWindowsCallbackArg): any
local function with_windows(callback)
  ---@type table<string, string[]>
  local open_windows = {}

  get_windows(function(workspace_and_windows)
    for _, entry in ipairs(workspace_and_windows) do
      local workspace = entry.workspace
      local app = entry['app-name']
      if open_windows[workspace] == nil then
        open_windows[workspace] = {}
      end
      table.insert(open_windows[workspace], app)
    end
    get_focused_workspaces(function(focused_workspaces)
      get_visible_workspaces(function(visible_workspaces)
        callback {
          open_windows = open_windows,
          focused_workspaces = focused_workspaces,
          visible_workspaces = visible_workspaces,
        }
      end)
    end)
  end)
end

---@param workspace string
---@param args WithWindowsCallbackArg
local function update_window(workspace, args)
  local open_windows = args.open_windows[workspace]
  local focused_workspaces = args.focused_workspaces
  local visible_workspaces = args.visible_workspaces

  if open_windows == nil then
    open_windows = {}
  end

  local icon_line = ''
  local no_app = true
  for _, open_window in ipairs(open_windows) do
    no_app = false
    local app = open_window
    local lookup = app_icons[app]
    local icon = ((lookup == nil) and app_icons['Default'] or lookup)
    icon_line = icon_line .. ' ' .. icon
  end

  sbar.animate('tanh', 10, function()
    for _, visible_workspace in ipairs(visible_workspaces) do
      if no_app and workspace == visible_workspace['workspace'] then
        local monitor_id = visible_workspace['monitor-appkit-nsscreen-screens-id']
        icon_line = ''
        workspaces[workspace]:set {
          icon = { drawing = true },
          label = {
            string = icon_line,
            drawing = true,
            font = settings.font.icon,
            y_offset = -1,
          },
          background = { drawing = true },
          padding_right = 1,
          padding_left = 1,
          display = monitor_id,
        }
        return
      end
    end
    if no_app and workspace ~= focused_workspaces then
      workspaces[workspace]:set {
        icon = { drawing = false },
        label = { drawing = false },
        background = { drawing = false },
        padding_right = 0,
        padding_left = 0,
      }
      return
    end
    if no_app and workspace == focused_workspaces then
      icon_line = ''
      workspaces[workspace]:set {
        icon = { drawing = true },
        label = {
          string = icon_line,
          drawing = true,
          font = settings.font.icon,
          y_offset = -1,
        },
        background = { drawing = true },
        padding_right = 1,
        padding_left = 1,
      }
    end

    workspaces[workspace]:set {
      icon = { drawing = true },
      label = { drawing = true, string = icon_line },
      background = { drawing = true },
      padding_right = 1,
      padding_left = 1,
    }
  end)
end

local function update_windows()
  with_windows(function(args)
    for workspace, _ in pairs(workspaces) do
      update_window(workspace, args)
    end
  end)
end

local function update_workspace_monitor()
  ---@type table<string, number>
  local workspace_monitor = {}
  get_workspaces(function(workspaces_and_monitors)
    for _, entry in ipairs(workspaces_and_monitors) do
      local space_index = entry.workspace
      local monitor_id = math.floor(entry['monitor-appkit-nsscreen-screens-id'])
      workspace_monitor[space_index] = monitor_id
    end
    for workspace_index, _ in pairs(workspaces) do
      workspaces[workspace_index]:set {
        display = workspace_monitor[workspace_index],
      }
    end
  end)
end

get_workspaces(function(workspaces_and_monitors)
  for _, entry in ipairs(workspaces_and_monitors) do
    local workspace_name = entry.workspace

    local workspace = sbar.add('item', {
      icon = {
        color = colors.workspaces.label,
        highlight_color = colors.workspaces.label_focused,
        drawing = false,
        string = workspace_name,
        padding_left = 12,
        padding_right = 4,
        font = settings.font.base,
      },
      label = {
        padding_right = 12,
        color = colors.workspaces.icon,
        highlight_color = colors.workspaces.icon_focused,
        font = settings.font.icon,
      },
      padding_right = 8,
      padding_left = 8,
      click_script = 'aerospace workspace ' .. workspace_name,
      background = {
        color = colors.workspaces.item_background,
        height = 28,
        corner_radius = 8,
      },
    })

    workspaces[workspace_name] = workspace

    ---@param env AerospaceWorkspaceChangeEnv
    workspace:subscribe('aerospace_workspace_change', function(env)
      local focused_workspace = env.FOCUSED_WORKSPACE
      local is_focused = focused_workspace == workspace_name

      sbar.animate('tanh', 10, function()
        workspace:set {
          icon = { highlight = is_focused },
          label = { highlight = is_focused },
          blur_radius = 30,
          background = {
            color = is_focused and colors.workspaces.item_background_focused or colors.workspaces.item_background,
          },
        }
      end)
    end)
  end

  -- initial setup
  update_windows()
  update_workspace_monitor()

  root:subscribe('aerospace_focus_change', function()
    update_windows()
  end)

  root:subscribe('display_change', function()
    update_workspace_monitor()
    update_windows()
  end)

  get_focused_workspaces(function(focused_workspace)
    local focused_workspace = focused_workspace:match '^%s*(.-)%s*$'
    workspaces[focused_workspace]:set {
      icon = { highlight = true },
      label = { highlight = true },
      background = {
        color = colors.workspaces.item_background_focused,
      },
    }
  end)
end)
