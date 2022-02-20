vim.cmd [[
    " Enable True Color support.
    set termguicolors
    set background=dark
    colorscheme undercity
]]

local util = require('mjlaufer.util')

local ts_configs = util.prequire('nvim-treesitter.configs')
if not ts_configs then
    return
end

ts_configs.setup {
    highlight = {enable = true},
    incremental_selection = {enable = true},
    ensure_installed = {
        'css',
        'go',
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
