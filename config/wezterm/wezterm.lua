local w = require 'wezterm'
local act = w.action

local function is_vim(pane)
  -- This is set by the plugin, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == 'true'
end

local config = {}
if w.config_builder then
  config = w.config_builder()
end

config.term = 'wezterm'
config.front_end = 'WebGpu'

-- Appearance

-- Color scheme
local kanagawa = {
  foreground = '#dcd7ba',
  background = '#1b1b23',

  cursor_bg = '#9CABCA',
  cursor_fg = '#252535',
  cursor_border = '#c8c093',

  selection_fg = '#c8c093',
  selection_bg = '#2d4f67',

  scrollbar_thumb = '#16161d',
  split = '#16161d',

  ansi = { '#090618', '#c34043', '#98BB6C', '#c0a36e', '#7e9cd8', '#957fb8', '#6a9589', '#c8c093' },
  brights = { '#727169', '#e82424', '#98bb6c', '#e6c384', '#7fb4ca', '#938aa9', '#7aa89f', '#dcd7ba' },
  indexed = { [16] = '#ffa066', [17] = '#ff5d62' },
}
local palenightfall = {
  foreground = '#959DCB',
  background = '#252837',

  cursor_bg = '#82AAff',
  cursor_fg = '#252535',
  cursor_border = '#c8c093',

  selection_fg = '#292D3E',
  selection_bg = '#959DCB',

  scrollbar_thumb = '#16161d',
  split = '#4e5579',

  ansi = { '#252837', '#F07178', '#C3E88D', '#FFCB6B', '#82AAFF', '#C792EA', '#89DDFF', '#7982B4' },
  brights = { '#4e5579', '#FF8B92', '#DDFFA7', '#FFE585', '#9CC4FF', '#E1ACFF', '#A3F7FF', '#FFFFFF' },
}
config.color_schemes = {
  ['My Kanagawa'] = kanagawa,
  ['Palenightfall'] = palenightfall,
}
config.color_scheme = 'My Kanagawa'

config.font = w.font('Victor Mono', { weight = 'Medium' })
config.font_size = 16
config.line_height = 1.55
config.strikethrough_position = '0.5cell'

config.hide_tab_bar_if_only_one_tab = true

config.window_decorations = 'RESIZE'
config.use_fancy_tab_bar = false

config.max_fps = 120

config.colors = {
  tab_bar = {
    background = kanagawa.background,

    active_tab = {
      bg_color = kanagawa.ansi[1],
      fg_color = kanagawa.brights[5],
    },

    inactive_tab = {
      bg_color = kanagawa.background,
      fg_color = kanagawa.brights[8],
    },

    inactive_tab_hover = {
      bg_color = '#16161D',
      fg_color = kanagawa.ansi[8],
    },

    new_tab = {
      bg_color = kanagawa.background,
      fg_color = kanagawa.brights[8],
    },

    new_tab_hover = {
      bg_color = '#16161D',
      fg_color = kanagawa.ansi[8],
    },
  },
}

config.inactive_pane_hsb = {
  brightness = 0.7,
  saturation = 0.8,
}

config.window_background_opacity = 0.9
config.text_background_opacity = 0.9
config.macos_window_background_blur = 25

-- Keyboard shortcuts

local direction_keys = {
  Left = 'h',
  Down = 'j',
  Up = 'k',
  Right = 'l',
  -- Reverse lookup
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = w.action_callback(function(win, pane)
      if is_vim(pane) then
        -- Pass the keys through to nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

config.disable_default_key_bindings = true
config.keys = {
  { key = 'q', mods = 'CMD', action = act.QuitApplication },
  { key = 'r', mods = 'CMD', action = act.ReloadConfiguration },
  { key = 'l', mods = 'CMD', action = act.ShowDebugOverlay },

  { key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
  { key = 'n', mods = 'CMD|SHIFT', action = act.SpawnWindow },
  { key = '-', mods = 'CMD', action = act.DecreaseFontSize },
  { key = '=', mods = 'CMD', action = act.IncreaseFontSize },
  { key = '0', mods = 'CMD', action = act.ResetFontSize },

  { key = 'w', mods = 'CMD', action = act.CloseCurrentTab { confirm = true } },
  { key = '1', mods = 'CMD', action = act.ActivateTab(0) },
  { key = '2', mods = 'CMD', action = act.ActivateTab(1) },
  { key = '3', mods = 'CMD', action = act.ActivateTab(2) },
  { key = '4', mods = 'CMD', action = act.ActivateTab(3) },
  { key = '5', mods = 'CMD', action = act.ActivateTab(4) },
  { key = '6', mods = 'CMD', action = act.ActivateTab(5) },
  { key = '7', mods = 'CMD', action = act.ActivateTab(6) },
  { key = '8', mods = 'CMD', action = act.ActivateTab(7) },
  { key = '9', mods = 'CMD', action = act.ActivateTab(-1) },

  { key = 'a', mods = 'CMD', action = act.SplitHorizontal },
  { key = 's', mods = 'CMD', action = act.SplitVertical },
  { key = 'f', mods = 'CMD', action = act.TogglePaneZoomState },
  { key = '/', mods = 'CMD', action = act.Search { CaseSensitiveString = '' } },
  { key = '[', mods = 'CMD', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'CMD', action = act.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },

  { key = 'u', mods = 'CMD', action = act.ScrollByPage(-0.5) },
  { key = 'd', mods = 'CMD', action = act.ScrollByPage(0.5) },
  { key = 'y', mods = 'CMD', action = act.ScrollByLine(-3) },
  { key = 'e', mods = 'CMD', action = act.ScrollByLine(3) },

  { key = 'h', mods = 'CMD|SHIFT', action = act.AdjustPaneSize { 'Left', 1 } },
  { key = 'l', mods = 'CMD|SHIFT', action = act.AdjustPaneSize { 'Right', 1 } },
  { key = 'k', mods = 'CMD|SHIFT', action = act.AdjustPaneSize { 'Up', 1 } },
  { key = 'j', mods = 'CMD|SHIFT', action = act.AdjustPaneSize { 'Down', 1 } },

  { key = 'p', mods = 'CMD', action = act.ScrollToPrompt(-1) },
  { key = 'n', mods = 'CMD', action = act.ScrollToPrompt(1) },

  { key = 'x', mods = 'CMD', action = act.ActivateCopyMode },

  {
    key = 'g',
    mods = 'CMD',
    action = w.action_callback(function(win, pane)
      win:perform_action(
        act.SplitHorizontal {
          args = { 'zsh', '-ic', 'lazygit' },
        },
        pane
      )
      win:perform_action(act.SetPaneZoomState(true), pane)
    end),
  },

  {
    key = 't',
    mods = 'CMD',
    action = w.action.SpawnCommandInNewTab {
      args = { 'zsh', '-i' },
      set_environment_variables = {
        OPEN_PROJECT = '1',
      },
    },
  },

  -- Open URLs with cmd+o
  {
    key = 'o',
    mods = 'CMD',
    action = act.QuickSelectArgs {
      label = 'open url',
      patterns = { 'https?://[^\\s)]+' },
      action = w.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        w.open_with(url)
      end),
    },
  },

  split_nav('move', 'h'),
  split_nav('move', 'j'),
  split_nav('move', 'k'),
  split_nav('move', 'l'),
  -- resize panes
  split_nav('resize', 'h'),
  split_nav('resize', 'j'),
  split_nav('resize', 'k'),
  split_nav('resize', 'l'),
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'SHIFT',
    action = w.action.OpenLinkAtMouseCursor,
  },
}

--- Behaviour

config.scrollback_lines = 10000

config.adjust_window_size_when_changing_font_size = false

return config
