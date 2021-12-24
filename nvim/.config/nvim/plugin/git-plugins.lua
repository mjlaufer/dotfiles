vim.cmd [[
let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_date_format = '%m/%d/%y'

" Color for git blamer text
highlight Blamer guifg=#595959
]]

require('gitsigns').setup()

require('diffview').setup({use_icons = true})

local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

keymap('n', '<leader>gb', ':BlamerToggle<CR>', opts)
keymap('n', '<leader>gd', ':DiffviewOpen<CR>', opts)
keymap('n', '<leader>gdc', ':DiffviewClose<CR>', opts)
