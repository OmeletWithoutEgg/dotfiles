local wezterm = require('wezterm')

local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

local breeze_dark = wezterm.get_builtin_color_schemes()['Breeze']
breeze_dark.background = '#232627'

return {
    color_scheme = 'BreezeDark',
    color_schemes = { ['BreezeDark'] = breeze_dark },
    -- check_for_updates = false,
    warn_about_missing_glyphs = false,
    -- color_scheme = 'Gruvbox Dark',
    font = wezterm.font_with_fallback({ 'Hack Nerd Font', 'Noto Sans CJK TC' }),
    font_size = 14,
    window_decorations = 'NONE',
    -- enable_kitty_graphics = true,
}
