local util = require('mjlaufer.util')
local map = util.map

require('nvim-dap-virtual-text').setup()

util.useWhichKey({['<leader>it'] = {name = 'DAP Virtual Text'}})

map('n', '<leader>itr', ':DapVirtualTextForceRefresh<CR>', 'Force refresh')
map('n', '<leader>itt', ':DapVirtualTextToggle<CR>', 'Toggle')
