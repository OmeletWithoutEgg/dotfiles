local wezterm = require('wezterm')

local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

-- local breeze = wezterm.get_builtin_color_schemes()['Breeze']
-- breeze.visual_bell = '#202020' -- TODO remove this after sufficient update

return {
    color_scheme = 'Breeze',
    -- color_schemes = {
    --     ['BreezeCustom'] = breeze,
    -- },
    -- colors = { background = '#232627' },
    -- check_for_updates = false,
    font = wezterm.font_with_fallback({
        {
            -- family = 'Monocraft',
            family = 'Source Code Pro Medium',
            -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
        },
        'Symbols Nerd Font',
        'Noto Sans Symbols2',
        'Noto Sans CJK TC',
    }),
    font_size = 24,

    window_decorations = 'NONE',
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0
    },
    -- enable_kitty_graphics = true,
    default_gui_startup_args = { 'start', '--always-new-process' },

    use_fancy_tab_bar = false,
    xim_im_name = 'ibus',
    adjust_window_size_when_changing_font_size = false,
    hide_tab_bar_if_only_one_tab = true,

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
}
