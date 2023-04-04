local util = require('mjlaufer.util')
local map = util.map

require('dapui').setup()

util.useWhichKey({['<leader>iu'] = {name = 'DAP UI'}})

map('n', '<leader>iui', ':lua require("dapui").toggle()<CR>', 'Toggle UI')
map('n', '<leader>ius', ':lua require("dapui").toggle("sidebar")<CR>', 'Toggle sidebar')
map('n', '<leader>iut', ':lua require("dapui").toggle("tray")<CR>', 'Toggle tray')
