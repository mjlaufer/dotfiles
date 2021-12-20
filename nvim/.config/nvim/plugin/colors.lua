vim.cmd([[
" Enable True Color support.
set termguicolors

set background=dark

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_bold = 0
colorscheme gruvbox
]])

require'nvim-treesitter.configs'.setup {
    highlight = { enable = true },
    incremental_selection = { enable = true },
    ensure_installed = {
        "css",
        "html",
        "javascript",
        "json",
        "scss",
        "tsx",
        "typescript",
        "yaml"
    }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }

require('colorizer').setup({
    html = {
        mode = 'foreground';
    };
    css = {
        rgb_fn = true;
    };
    'scss';
    'javascript';
    'typescript';
})
