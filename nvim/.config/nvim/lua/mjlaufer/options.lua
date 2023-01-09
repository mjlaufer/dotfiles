local options = {
    showmode = false, -- Do not show a message for mode; Lualine handles this.
    errorbells = false,
    timeoutlen = 300,
    mouse = 'a',
    scrolloff = 8, -- Scroll when cursor is 8 lines from top or bottom.

    -- Indents
    tabstop = 4,
    softtabstop = 4, -- Number of spaces inserted for a tab.
    shiftwidth = 4, -- Indentation width.
    expandtab = true, -- Convert tabs to spaces.
    smartindent = true,
    wrap = false,

    -- Lines and columns
    cursorline = true,
    relativenumber = true,
    nu = true, -- Show current line number.
    signcolumn = 'yes', -- Add a left column to display diagnostic signs.
    colorcolumn = '100',

    -- Search (case-insensitive unless using \C or a capital in search)
    hlsearch = true,
    incsearch = true, -- Highlight the currently matched string while searching.
    ignorecase = true, -- Ignore casing in search patterns.
    smartcase = true, -- Override ignorecase if search pattern contains uppercase.

    -- Folds
    foldmethod = 'expr',
    foldexpr = 'nvim_treesitter#foldexpr()',
    foldlevel = 99,

    -- Backup/undo
    swapfile = false,
    backup = false,
    undodir = vim.fn.stdpath('data') .. '/undodir',
    undofile = true,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
