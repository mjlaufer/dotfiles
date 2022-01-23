local diffview_status_ok, diffview = pcall(require, 'diffview');
if not diffview_status_ok then
    return
end

diffview.setup({use_icons = true})

local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

keymap('n', '<leader>gdo', ':DiffviewOpen<CR>', opts)
keymap('n', '<leader>gdc', ':DiffviewClose<CR>', opts)

require('which-key').register({
    ['<leader>gd'] = {name = 'Git diff view', o = 'Open diff view', c = 'Close diff view'},
})

local blamer_status_ok = pcall(require, 'diffview');
if not blamer_status_ok then
    return
end

vim.cmd [[
    let g:blamer_enabled = 1
    let g:blamer_delay = 500
    let g:blamer_date_format = '%m/%d/%y'

    " Color for git blamer text
    highlight Blamer guifg=#595959
]]

keymap('n', '<leader>gb', ':BlamerToggle<CR>', opts)

require('which-key').register({['<leader>g'] = {name = 'Git', b = 'Toggle git blamer'}})

local gitsigns_status_ok, gitsigns = pcall(require, 'gitsigns')
if not gitsigns_status_ok then
    return
end

gitsigns.setup()
