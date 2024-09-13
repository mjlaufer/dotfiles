-- GLOBAL EDITOR VARIABLES

-- Set <space> as the leader key (See `:help mapleader`).
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used).
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- OPTIONS

local options = {
    showmode = false, -- Do not show a message for mode; Lualine handles this.
    errorbells = false,
    timeoutlen = 300, -- Decrease mapped sequence wait time (and display which-key popup sooner).
    updatetime = 250,
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
    nu = true, -- Show current line number.
    relativenumber = true,
    cursorline = true,
    signcolumn = 'yes', -- Add a left column to display diagnostic signs.
    colorcolumn = '100',

    -- Search (case-insensitive unless using \C or a capital in search)
    hlsearch = true,
    incsearch = true, -- Highlight the currently matched string while searching.
    ignorecase = true, -- Ignore casing in search patterns.
    smartcase = true, -- Override ignorecase if search pattern contains uppercase.
    inccommand = 'split', -- Preview substitutions as you type.

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

-- Sync clipboard between OS and Neovim. (See `:help 'clipboard'`.)
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

-- AUTOCOMMANDS

-- Highlight when yanking (copying) text. See `:help vim.highlight.on_yank()`.
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
