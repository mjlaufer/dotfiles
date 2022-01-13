vim.cmd [[
    " Enable True Color support.
    set termguicolors
    set background=dark
    colorscheme undercity
]]

require('nvim-treesitter.configs').setup {
    highlight = {enable = true},
    incremental_selection = {enable = true},
    ensure_installed = {
        'css',
        'html',
        'javascript',
        'json',
        'lua',
        'scss',
        'tsx',
        'typescript',
        'yaml',
    },
    context_commentstring = {enable = true, enable_autocmd = false},
}

local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.used_by = {'javascript', 'typescript.tsx'}

require('colorizer').setup({
    html = {mode = 'foreground'},
    css = {rgb_fn = true, hsl_fn = true},
    'scss',
    'javascript',
    'typescript',
    'lua',
})
