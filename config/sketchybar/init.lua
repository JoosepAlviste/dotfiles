-- Require the sketchybar module
sbar = require 'sketchybar'
local colors = require 'colors'

sbar.begin_config()

sbar.bar {
  height = 38,
  color = colors.bar.bg,
  padding_right = 8,
  padding_left = 8,
}

require 'items'

sbar.end_config()

sbar.event_loop()
