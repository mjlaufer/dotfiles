local util = require('mjlaufer.util')

vim.cmd [[
    let g:blamer_enabled = 1
    let g:blamer_delay = 500
    let g:blamer_date_format = '%m/%d/%y'

    " Color for git blamer text
    highlight Blamer guifg=#595959
]]

local opts = {noremap = true, silent = true}

util.map('n', '<leader>gb', ':BlamerToggle<CR>', opts)

util.useWhichKey({['<leader>gb'] = 'Toggle git blamer'})
