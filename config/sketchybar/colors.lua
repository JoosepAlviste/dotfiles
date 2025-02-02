---@param color number
---@param alpha number
---@return number
local function with_alpha(color, alpha)
  if alpha > 1.0 or alpha < 0.0 then
    return color
  end
  return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

---Primitive colors from
---https://github.com/rebelot/kanagawa.nvim/tree/master?tab=readme-ov-file#color-palette
local primitives = {
  black = 0xFF000000,
  white = 0xFFFFFFFF,

  fuji_white = 0xFFDCD7BA,
  old_white = 0xFFC8C093,
  light_blue = 0xFFA3D4D5,
  crystal_blue = 0xFF7E9CD8,
  spring_violet_2 = 0xFF9CABCA,
  ronin_yellow = 0xFFFF9E3B,

  transparent = 0x00000000,
}

return {
  primitive = primitives,

  bar = {
    bg = with_alpha(primitives.black, 0.15),
    fg = primitives.white,
    fg_secondary = with_alpha(primitives.white, 0.4),
  },

  workspaces = {
    icon = with_alpha(primitives.white, 0.4),
    icon_focused = primitives.white,

    label = with_alpha(primitives.white, 0.8),
    label_focused = primitives.white,

    item_background = primitives.transparent,
    item_background_focused = with_alpha(primitives.white, 0.1),
  },
}
