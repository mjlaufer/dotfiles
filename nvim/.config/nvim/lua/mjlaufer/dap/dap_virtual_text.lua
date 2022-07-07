local util = require('mjlaufer.util')
local map = util.map

local dap_virtual_text = util.prequire('nvim-dap-virtual-text')
if not dap_virtual_text then
    return
end

dap_virtual_text.setup()

util.useWhichKey({['<leader>it'] = {name = 'DAP Virtual Text'}})

map('n', '<leader>itr', ':DapVirtualTextForceRefresh<CR>', 'Force refresh')
map('n', '<leader>itt', ':DapVirtualTextToggle<CR>', 'Toggle')
