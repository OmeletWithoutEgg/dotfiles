local wezterm = require('wezterm')
local act = wezterm.action


function ToggleTransparent()
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity or
    overrides.window_background_opacity == 0.95 then
    overrides.window_background_opacity = 1
  else
    overrides.window_background_opacity = 0.95
  end
  window:set_config_overrides(overrides)
end

-- In KDE plasma (wayland), set special window property "window size" to proper size
-- https://github.com/wezterm/wezterm/issues/3173
wezterm.on('window-config-reloaded', function(window, pane)
  -- approximately identify this gui window, by using the associated mux id
  local id = tostring(window:window_id())

  -- maintain a mapping of windows that we have previously seen before in this event handler
  local seen = wezterm.GLOBAL.seen_windows or {}
  -- set a flag if we haven't seen this window before
  local is_new_window = not seen[id]
  -- and update the mapping
  seen[id] = true
  wezterm.GLOBAL.seen_windows = seen

  -- now act upon the flag
  if is_new_window then
    window:maximize()
  end
end)

return {
  color_scheme = 'Breeze',
  -- color_scheme = 'tokyonight_moon',
  check_for_updates = true,
  window_background_opacity = 0.95,
  font = wezterm.font_with_fallback({
    -- { family = 'UbuntuMono Nerd Font', },
    {
      -- family = 'Monocraft',
      -- family = 'Source Code Pro Medium',
      -- family = 'FiraCode Nerd Font',
      -- family = 'Iosevka NFM',
      family = 'JetBrains Mono',
      harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    },
    {
      family = 'Symbols Nerd Font',
    },
    'Noto Sans Symbols 2',
    'Noto Sans CJK TC',
    'Noto Sans CJK JP',
    'Noto Sans Math',
  }),
  font_size = 14,

  window_decorations = 'NONE',
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  -- enable_kitty_graphics = true,

  -- front_end = 'WebGpu',

  use_fancy_tab_bar = false,
  adjust_window_size_when_changing_font_size = false,
  hide_tab_bar_if_only_one_tab = true,

  use_ime = true,
  -- xim_im_name = 'ibus',

  default_gui_startup_args = { 'start', '--always-new-process' },

  visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 75,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 75,
  },
  colors = {
    visual_bell = '#131617',
  },
  audible_bell = 'Disabled',

  keys = {
    { key = '1', mods = 'ALT', action = act.ActivateTab(0), },
    { key = '2', mods = 'ALT', action = act.ActivateTab(1), },
    { key = '3', mods = 'ALT', action = act.ActivateTab(2), },
    { key = '4', mods = 'ALT', action = act.ActivateTab(3), },
    { key = '5', mods = 'ALT', action = act.ActivateTab(4), },
    { key = '6', mods = 'ALT', action = act.ActivateTab(5), },
    { key = '7', mods = 'ALT', action = act.ActivateTab(6), },
    { key = '8', mods = 'ALT', action = act.ActivateTab(7), },
  },
}
