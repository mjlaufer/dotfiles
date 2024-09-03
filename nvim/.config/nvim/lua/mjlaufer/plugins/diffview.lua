local util = require('mjlaufer.util')
local map = util.map

util.useWhichKey({ { '<leader>g', group = 'Git' } })

map('n', '<leader>go', ':DiffviewOpen<CR>', 'Open diff')
map('n', '<leader>gc', ':DiffviewClose<CR>', 'Close diff')
