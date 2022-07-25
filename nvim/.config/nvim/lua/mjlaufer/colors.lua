vim.cmd [[
    " Enable True Color support.
    set termguicolors

    set background=dark
    colorscheme glint

    let g:markdown_fenced_languages = ['html', 'sh', 'bash=sh', 'javascript', 'js=javascript', 'typescript', 'ts=typescript', 'go', 'lua']
]]

local util = require('mjlaufer.util')

local ts_configs = util.prequire('nvim-treesitter.configs')
if not ts_configs then
    return
end

ts_configs.setup {
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
    highlight = {enable = true},
    incremental_selection = {enable = true},
    context_commentstring = {enable = true, enable_autocmd = false},
}

local ft_to_parser = require('nvim-treesitter.parsers').filetype_to_parsername
ft_to_parser.tsx = {'javascript', 'typescript.tsx'}
