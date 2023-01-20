local wezterm = require('wezterm')

return {
    color_scheme = 'Breeze',
    check_for_updates = true,
    window_background_opacity = 0.9,
    font = wezterm.font_with_fallback({
        {
            -- family = 'Monocraft',
            family = 'Source Code Pro Medium',
            -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
        },
        'Symbols Nerd Font',
        'Noto Sans Symbols2',
        'Noto Sans CJK TC',
        'Noto Sans CJK JP',
        'Noto Sans Math',
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

    -- front_end = "WebGpu",

    use_fancy_tab_bar = false,
    adjust_window_size_when_changing_font_size = false,
    hide_tab_bar_if_only_one_tab = true,

    use_ime = true,
    xim_im_name = 'ibus',

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
}
