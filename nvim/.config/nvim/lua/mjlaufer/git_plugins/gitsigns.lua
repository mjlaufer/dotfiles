local util = require('mjlaufer.util')
local map = util.map

local gitsigns = util.prequire('gitsigns')
if not gitsigns then
    return
end

gitsigns.setup({
    current_line_blame = true,
    current_line_blame_opts = {delay = 500},
    current_line_blame_formatter = '    <author>, <author_time:%m/%d/%y> - <summary>',
})

map('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', 'Toggle git blame')
