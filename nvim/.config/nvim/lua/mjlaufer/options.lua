local options = {
    hidden = true, -- Keep edited buffers around in the background.
    showmode = false, -- Do not show a message for mode; Lualine handles this.
    tabstop = 4,
    softtabstop = 4, -- Number of spaces inserted for a tab.
    shiftwidth = 4, -- Indentation width.
    expandtab = true, -- Convert tabs to spaces.
    smartindent = true,
    wrap = false,
    cursorline = true,
    relativenumber = true,
    nu = true, -- Show current line number.
    signcolumn = 'yes', -- Add a left column to display diagnostic signs.
    colorcolumn = '100',
    scrolloff = 8, -- Scroll when cursor is 8 lines from top or bottom.
    hlsearch = true,
    incsearch = true, -- Highlight the currently matched string while searching.
    ignorecase = true, -- Ignore casing in search patterns.
    smartcase = true, -- Override ignorecase if search pattern contains uppercase.
    swapfile = false,
    backup = false,
    errorbells = false,
    timeoutlen = 300,
    mouse = 'a',
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Turn on 'wrap' for markdown files
vim.cmd [[
    augroup MarkdownWrap
        autocmd!
        autocmd FileType markdown set wrap
    augroup END
]]