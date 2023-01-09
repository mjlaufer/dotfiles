local util = require('mjlaufer.util')
local map = util.map

local nvim_tree = util.prequire('nvim-tree')
if not nvim_tree then
    return
end

nvim_tree.setup({view = {width = 36}})

util.useWhichKey({['<leader>e'] = {name = 'Explorer'}})

map('n', '<leader>ee', ':NvimTreeToggle<CR>', 'Toggle')
map('n', '<leader>ef', ':NvimTreeFindFile<CR>', 'Find file')
map('n', '<leader>ec', ':NvimTreeCollapse<CR>', 'Collapse')
