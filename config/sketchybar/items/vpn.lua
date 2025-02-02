local constants = require 'constants'
local settings = require 'settings'
local colors = require 'colors'
local sleep = require('sketchybar_utils').sleep

---Requires the `tunblkctl` CLI
local vpn = sbar.add('item', constants.items.VPN, {
  position = 'right',
  label = {
    font = settings.font.icon,
    color = colors.bar.fg_secondary,
    string = ':openvpn_connect:',
    highlight_color = colors.bar.fg,
  },
  background = {
    padding_right = 12,
  },
})

---@param callback fun(is_connected: boolean): any
local function get_is_connected(callback)
  sbar.exec("tunblkctl status --strip | awk '{print $2}'", function(status)
    local status_trimmed = string.gsub(status, '%s+', '')
    callback(status_trimmed == 'CONNECTED')
  end)
end

local function update_highlight()
  get_is_connected(function(is_connected)
    sbar.animate('tanh', 10, function()
      vpn:set {
        label = {
          highlight = is_connected,
        },
      }
    end)
  end)
end

vpn:subscribe({ 'forced', 'system_woke' }, function()
  update_highlight()
end)

vpn:subscribe('wifi_change', function()
  -- Make sure that the VPN connection is established before trying to update
  sleep(1)
  update_highlight()
end)

vpn:subscribe('mouse.clicked', function()
  get_is_connected(function(is_connected)
    local command = is_connected and 'disconnect' or 'connect'

    sbar.exec(string.format("tunblkctl %s $(tunblkctl status --strip | awk '{print $1}')", command), function()
      update_highlight()
    end)
  end)
end)
