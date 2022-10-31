local util = require('mjlaufer.util')
local map = util.map

local diffview = util.prequire('diffview')
if not diffview then
    return
end

map('n', '<leader>go', ':DiffviewOpen<CR>', 'Open diff')
map('n', '<leader>gc', ':DiffviewClose<CR>', 'Close diff')
