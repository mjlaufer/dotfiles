local util = require('mjlaufer.util')

local dap_virtual_text = util.prequire('nvim-dap-virtual-text')
if not dap_virtual_text then
    return
end

dap_virtual_text.setup()

local opts = {noremap = true, silent = true}

util.map('n', '<leader>itr', ':DapVirtualTextForceRefresh<CR>', opts)
util.map('n', '<leader>itt', ':DapVirtualTextToggle<CR>', opts)

util.useWhichKey({['<leader>it'] = {name = 'DAP Virtual Text', r = 'Force refresh', t = 'Toggle'}})
