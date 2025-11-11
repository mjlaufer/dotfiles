local util = require('mjlaufer.util')
local map = util.map

require('gitsigns').setup({
    current_line_blame = true,
    current_line_blame_opts = { delay = 500 },
    current_line_blame_formatter = '    <author>, <author_time:%m/%d/%y> - <summary>',
    gh = true,
})

util.useWhichKey({ { '<leader>g', group = 'Git' } })

map('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', 'Toggle line blame')
map('n', '[g', ':Gitsigns prev_hunk<CR>', 'Previous hunk')
map('n', ']g', ':Gitsigns prev_hunk<CR>', 'Next hunk')
map('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', 'Preview hunk')
map('n', '<leader>gr', ':Gitsigns reset_hunk<CR>', 'Reset hunk')
map('n', '<leader>gs', ':Gitsigns stage_hunk<CR>', 'Stage hunk')
