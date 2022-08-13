local wezterm = require('wezterm')

local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  color_scheme = 'Breeze',
  check_for_updates = false,
  -- color_scheme = 'Gruvbox Dark',
  font = wezterm.font_with_fallback({ 'Hack', 'Noto Sans CJK TC' }),
  window_decorations = 'NONE',
}
