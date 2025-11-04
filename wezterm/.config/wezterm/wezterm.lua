local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.color_scheme = 'inklight'

-- Fancy tab bar
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.window_frame = {
    font = wezterm.font({
        family = 'Roboto',
        weight = 'Regular',
    }),
    font_size = 16.0,
    active_titlebar_bg = '#e5e5e5',
    inactive_titlebar_bg = '#e5e5e5',
}
config.colors = {
    tab_bar = {
        background = '#e5e5e5',
        inactive_tab_edge = '#e5e5e5',
        active_tab = {
            bg_color = '#f2f2f2',
            fg_color = '#1b1b1b',
            intensity = 'Normal',
        },
        inactive_tab = {
            bg_color = '#e5e5e5',
            fg_color = '#555555',
            intensity = 'Normal',
        },
        inactive_tab_hover = {
            bg_color = '#f2f2f2',
            fg_color = '#1b1b1b',
        },
        new_tab = {
            bg_color = '#e5e5e5',
            fg_color = '#555555',
        },
        new_tab_hover = {
            bg_color = '#f2f2f2',
            fg_color = '#1b1b1b',
        },
    },
}

-- Combine Mac OS window controls with WezTerm's tab bar.
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

-- Window settings
config.initial_cols = 100
config.initial_rows = 40
config.window_background_opacity = 1.0
config.window_padding = {
    left = 16,
    right = 12,
    top = 12,
    bottom = 12,
}

-- Font settings
config.font = wezterm.font({
    family = 'JetBrains Mono',
    weight = 'Medium',
})
config.font_rules = {
    {
        intensity = 'Bold',
        font = wezterm.font({
            family = 'JetBrains Mono',
            weight = 'ExtraBold',
        }),
    },
}
config.font_size = 16.0
config.line_height = 1.1
config.freetype_load_target = 'Light'
config.freetype_render_target = 'HorizontalLcd'
config.front_end = 'WebGpu'

return config
