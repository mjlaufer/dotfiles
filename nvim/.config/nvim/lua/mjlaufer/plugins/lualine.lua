require('lualine').setup({
    options = { theme = 'flashy', always_divide_middle = false, globalstatus = true },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { { 'filename', file_status = true, path = 1 } },
        lualine_x = {
            {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            },
            'filetype',
        },
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extensions = { 'lazy', 'fugitive', 'nvim-tree', 'toggleterm' },
})
