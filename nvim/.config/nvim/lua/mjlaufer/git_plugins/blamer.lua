vim.cmd [[
    let g:blamer_enabled = 1
    let g:blamer_delay = 500
    let g:blamer_date_format = '%m/%d/%y'

    " Color for git blamer text
    highlight Blamer guifg=#595959
]]

local map = require('mjlaufer.util').map

map('n', '<leader>gb', ':BlamerToggle<CR>', 'Toggle git blamer')
