local util = require('mjlaufer.util')
local map = util.map

util.useWhichKey({['<leader>g'] = {name = 'Git'}})

require('gitsigns').setup({
    current_line_blame = true,
    current_line_blame_opts = {delay = 500},
    current_line_blame_formatter = '    <author>, <author_time:%m/%d/%y> - <summary>',
})

map('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', 'Toggle git blame')
