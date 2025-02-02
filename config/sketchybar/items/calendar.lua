local constants = require 'constants'
local settings = require 'settings'
local colors = require 'colors'

local calendar = sbar.add('item', constants.items.CALENDAR, {
  position = 'right',
  update_freq = 1,
  icon = { padding_left = 0, padding_right = 0 },
  label = { font = settings.font.base, color = colors.bar.fg },
  background = {
    padding_right = 12,
  },
})

calendar:subscribe({ 'forced', 'routine', 'system_woke' }, function()
  calendar:set {
    label = os.date('%a %d. %b %H:%M'):gsub(' 0', ' '),
  }
end)

calendar:subscribe('mouse.clicked', function()
  sbar.exec "open -a 'Calendar'"
end)
