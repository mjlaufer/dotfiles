colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_bold = 0

lua << EOF
require'nvim-treesitter.configs'.setup {
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
    ensure_installed = {
        "css",
        "html",
        "javascript",
        "json",
        "tsx",
        "typescript"
    }
}
EOF
