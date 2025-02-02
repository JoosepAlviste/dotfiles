local constants = require 'constants'
local settings = require 'settings'
local colors = require 'colors'
local filter_table = require('sketchybar_utils').filter_table
local split = require('sketchybar_utils').split

local UPCOMING_EVENTS_LIMIT_MINUTES = 15
local EVENT_SEPARATOR = '·'

local events = sbar.add('item', constants.items.EVENTS, {
  position = 'right',
  update_freq = 60,
  -- update_freq = 1,
  icon = { padding_left = 0, padding_right = 0 },
  label = { font = settings.font.base, color = colors.bar.fg },
  background = {
    padding_right = 12,
  },
})

---@class Event
---@field title string
---@field start_time integer|nil
---@field end_time integer|nil

---@param str string
---@return integer
local function parse_date(str)
  local y, m, d, h, min = str:match '^(%d+)-(%d+)-(%d+) (%d+):(%d+)$'
  return os.time { year = y, month = m, day = d, hour = h, min = min }
end

---@param str string
---@return integer|nil, integer|nil
local function get_event_times(str)
  local start_hours, start_minutes, end_hours, end_minutes = string.match(str, '(%d+):(%d+)%s+-%s+(%d+):(%d+)')
  ---@type integer|nil
  local start_time
  ---@type integer|nil
  local end_time
  if start_hours and start_minutes then
    start_time = parse_date(os.date(string.format('%%Y-%%m-%%d %d:%d', start_hours, start_minutes)))
  end
  if end_hours and end_minutes then
    end_time = parse_date(os.date(string.format('%%Y-%%m-%%d %d:%d', end_hours, end_minutes)))
  end

  return start_time, end_time
end

---@param event Event
local function get_event_time_addon(event)
  local now = os.time()

  local seconds_ago = now - event.start_time
  local minutes_ago = math.floor(seconds_ago / 60)

  local seconds_left = math.abs(now - event.end_time)
  local minutes_left = math.floor(seconds_left / 60)

  if minutes_ago < 0 then
    return string.format('in %sm', math.abs(minutes_ago))
  end

  if minutes_ago > 5 then
    return string.format('%sm left', minutes_left)
  end

  return string.format('%sm ago', minutes_ago)
end

---@param event Event
local function update_event_item(event)
  events:set {
    label = string.format('%s · %s', event.title, get_event_time_addon(event)),
    background = {
      padding_right = 12,
    },
  }
end

---@param events_string string
---@return Event[]
local function parse_events(events_string)
  ---@type Event[]
  local events_table = {}

  local event_lines = split(events_string, EVENT_SEPARATOR)
  for _, event_fields_str in ipairs(event_lines) do
    local event_data = split(event_fields_str, '\n')
    local event_name = event_data[1]
    local event_time = event_data[2]:gsub('^%s+', '')
    local start_time, end_time = get_event_times(event_time)

    table.insert(events_table, {
      title = event_name,
      start_time = start_time,
      end_time = end_time,
    })
  end

  return events_table
end

---@param callback fun(events: Event[]): any
local function get_events_upcoming(callback)
  sbar.exec(
    string.format(
      "icalBuddy --includeEventProps 'datetime,title' --bullet '%s' --noCalendarNames --timeFormat '%%H:%%M' eventsFrom:'now' to:'today'",
      EVENT_SEPARATOR
    ),
    ---@param events_output string
    function(events_output)
      local event_items = parse_events(events_output)

      callback(event_items)
    end
  )
end

---Set the event item as empty
local function clear_item()
  events:set {
    label = '',
    background = {
      padding_right = 0,
    },
  }
end

---@param event_items Event[]
local function update_relevant_events(event_items)
  local now = os.time()

  ---@param item Event
  local not_all_day_events = filter_table(function(item)
    return item.start_time ~= nil and item.end_time ~= nil
  end, event_items)

  ---@param item Event
  local upcoming_events = filter_table(function(item)
    local start_time_in = item.start_time - now
    return start_time_in > 0 and start_time_in <= (UPCOMING_EVENTS_LIMIT_MINUTES * 60)
  end, not_all_day_events)

  if #upcoming_events > 0 then
    update_event_item(upcoming_events[1])
    return
  end

  ---@param item Event
  local current_events = filter_table(function(item)
    local start_time_in = item.start_time - now
    return start_time_in <= 0
  end, not_all_day_events)

  if #current_events > 0 then
    update_event_item(current_events[1])
    return
  end

  clear_item()
end

events:subscribe({ 'forced', 'routine', 'system_woke' }, function()
  get_events_upcoming(function(event_items)
    update_relevant_events(event_items)
  end)
end)
