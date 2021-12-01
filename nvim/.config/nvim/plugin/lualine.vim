lua << EOF
require'nvim-web-devicons'.setup {
    override = {};
    default = true;
}

require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'gruvbox',
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
EOF
