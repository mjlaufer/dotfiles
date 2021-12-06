require'nvim-web-devicons'.setup {
    override = {};
    default = true;
}

local custom_gruvbox = require'lualine.themes.gruvbox'
custom_gruvbox.normal.a.bg = '#b8bb26' -- gruvbox-dark light-green

require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = custom_gruvbox,
        section_separators = {left = '', right = ''},
        component_separators = {left = '', right = ''},
        disabled_filetypes = {},
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'filename'},
        lualine_x = {
            { 'diagnostics', sources = { "nvim_lsp" }, symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
            'filetype'
        },
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {'fugitive'},
}
