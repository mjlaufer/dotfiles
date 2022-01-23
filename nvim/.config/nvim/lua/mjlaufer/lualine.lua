require'nvim-web-devicons'.setup({override = {}, default = true})

local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
    return
end

lualine.setup({
    options = {
        theme = 'undercity',
        icons_enabled = true,
        section_separators = {left = '', right = ''},
        component_separators = {left = '', right = ''},
        disabled_filetypes = {},
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'filename'},
        lualine_x = {
            {
                'diagnostics',
                sources = {'nvim_diagnostic'},
                symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
            },
            'filetype',
        },
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {'fugitive'},
})
