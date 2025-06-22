local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.color_scheme = "inklight"

-- Fancy tab bar
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.window_frame = {
    font_size = 16.0,
    active_titlebar_bg = '#e5e5e5',
    inactive_titlebar_bg = '#e5e5e5',
}
config.colors = {
    tab_bar = {
      background = "#e5e5e5",
      inactive_tab_edge = "#e5e5e5",
      active_tab = {
        bg_color = "#eeeeee",
        fg_color = "#353535",
        intensity = "Bold",
      },
      inactive_tab = {
        bg_color = "#e5e5e5",
        fg_color = "#555555",
        intensity = "Normal",
      },
      inactive_tab_hover = {
        bg_color = "#eeeeee",
        fg_color = "#353535",
      },
      new_tab = {
        bg_color = "#e5e5e5",
        fg_color = "#555555",
      },
      new_tab_hover = {
        bg_color = "#eeeeee",
        fg_color = "#353535",
      },
    },
}

config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

config.font = wezterm.font_with_fallback({
    { family = 'JetBrains Mono', weight = 'Regular' },
    { family = 'Symbols Nerd Font' },
})
config.font_size = 16.0

config.initial_cols = 100
config.initial_rows = 40

config.scrollback_lines = 2000

config.window_background_opacity = 1.0
config.window_padding = {
    left = 16,
    right = 16,
    top = 12,
    bottom = 12,
}

return config
