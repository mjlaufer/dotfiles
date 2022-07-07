local util = require('mjlaufer.util')
local map = util.map

local diffview = util.prequire('diffview')
if not diffview then
    return
end

diffview.setup({use_icons = true})

util.useWhichKey({['<leader>gd'] = {name = 'Git diff view'}})

map('n', '<leader>gdo', ':DiffviewOpen<CR>', 'Open')
map('n', '<leader>gdc', ':DiffviewClose<CR>', 'Close')
