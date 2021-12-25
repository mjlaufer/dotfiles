local options = {
    hidden = true, -- Keep edited buffers around in the background.
    tabstop = 4,
    softtabstop = 4, -- Number of spaces inserted for a tab.
    shiftwidth = 4, -- Indentation width.
    expandtab = true, -- Convert tabs to spaces.
    smartindent = true,
    wrap = false,
    relativenumber = true,
    nu = true, -- Show current line number.
    signcolumn = 'yes', -- Add a left column to display diagnostic signs.
    colorcolumn = '100',
    scrolloff = 8, -- Scroll when cursor is 8 lines from top or bottom.
    hlsearch = false, -- Remove highlight from search term when search is complete.
    incsearch = true, -- Highlight the currently matched string while searching.
    ignorecase = true, -- Ignore casing in search patterns.
    smartcase = true, -- Override ignorecase if search pattern contains uppercase.
    swapfile = false,
    backup = false,
    errorbells = false
}

for k, v in pairs(options) do vim.opt[k] = v end

vim.cmd [[
    augroup MarkdownWrap
        autocmd!
        autocmd FileType markdown set wrap
    augroup END
]]
