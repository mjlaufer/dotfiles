vim.cmd [[
    " Enable True Color support.
    set termguicolors
    set background=dark
    colorscheme undercity
]]

local ts_status_ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
if not ts_status_ok then
    return
end

ts_configs.setup {
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

local colorizer_status_ok, colorizer = pcall(require, 'colorizer')
if not colorizer_status_ok then
    return
end

colorizer.setup({
    html = {mode = 'foreground'},
    css = {rgb_fn = true, hsl_fn = true},
    'scss',
    'javascript',
    'typescript',
    'lua',
})
