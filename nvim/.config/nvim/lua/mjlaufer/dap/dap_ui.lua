local util = require('mjlaufer.util')

local dapui = util.prequire('dapui')
if not dapui then
    return
end

dapui.setup()

local opts = {noremap = true, silent = true}

util.map('n', '<leader>iui', ':lua require("dapui").toggle()<CR>', opts)
util.map('n', '<leader>ius', ':lua require("dapui").toggle("sidebar")<CR>', opts)
util.map('n', '<leader>iut', ':lua require("dapui").toggle("tray")<CR>', opts)

util.useWhichKey({
    ['<leader>iu'] = {name = 'DAP UI', i = 'Toggle UI', s = 'Toggle sidebar', t = 'Toggle tray'},
})
