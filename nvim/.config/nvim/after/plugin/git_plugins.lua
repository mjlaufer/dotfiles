local util = require('mjlaufer.util')
local map = util.map
local useWhichKey = util.useWhichKey

useWhichKey({['<leader>g'] = {name = 'Git'}})

local gitsigns = util.prequire('gitsigns')
if gitsigns then
    gitsigns.setup({
        current_line_blame = true,
        current_line_blame_opts = {delay = 500},
        current_line_blame_formatter = '    <author>, <author_time:%m/%d/%y> - <summary>',
    })

    map('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', 'Toggle git blame')
end

local diffview = util.prequire('diffview')
if diffview then
    map('n', '<leader>go', ':DiffviewOpen<CR>', 'Open diff')
    map('n', '<leader>gc', ':DiffviewClose<CR>', 'Close diff')
end
