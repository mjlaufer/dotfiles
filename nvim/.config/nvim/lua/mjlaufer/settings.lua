-- GLOBAL EDITOR VARIABLES

-- Set <space> as the leader key (See `:help mapleader`).
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used).
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- OPTIONS

local options = {
    termguicolors = true,
    showmode = false, -- Do not show a message for mode; Lualine handles this.
    errorbells = false,
    timeoutlen = 300, -- Mapped sequence wait time.
    updatetime = 100,
    mouse = 'a',
    scrolloff = 8, -- Scroll when cursor is 8 lines from top or bottom.
    winborder = 'rounded',
    pumborder = 'rounded',

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

    -- Completion
    autocomplete = true,
    completeopt = 'menuone,noselect,noinsert,fuzzy,popup',

    -- Folds
    foldmethod = 'expr',
    foldexpr = 'v:lua.vim.treesitter.foldexpr()',
    foldlevelstart = 99, -- Start with all folds open.

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

-- Highlight when yanking and shift registers 1-9 for yank history ("1p, "2p, etc.).
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight yank and maintain yank history in numbered registers',
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
        if vim.v.event.operator == 'y' then
            for i = 9, 1, -1 do
                vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
            end
        end
    end,
})

-- Auto-save on focus loss or buffer hide.
vim.api.nvim_create_autocmd({ 'BufHidden', 'FocusLost', 'WinLeave', 'CursorHold' }, {
    desc = 'Auto-save modified buffers',
    group = vim.api.nvim_create_augroup('AutoSave', { clear = true }),
    callback = function()
        if vim.bo.modified and vim.bo.buftype == '' and vim.fn.expand('%') ~= '' then
            vim.cmd('silent lockmarks update ++p')
        end
    end,
})
