local util = require('mjlaufer.util')
local map = util.map

local neotest = util.prequire('neotest')
local neotest_jest = util.prequire('neotest-jest')
if (not neotest or not neotest_jest) then
    return
end

neotest.setup({adapters = {neotest_jest({jestCommand = 'yarn test'})}})

util.useWhichKey({['<leader>s'] = {name = 'Spec'}})

map('n', '<leader>ss', ':lua require("neotest").run.run()<CR>', 'Run the nearest test')
map('n', '<leader>sf', ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>',
    'Run the current file')
map('n', '<leader>si', ':lua require("neotest").run.run({strategy = "dap})<CR>',
    'Debug the nearest test')
map('n', '<leader>sq', ':lua require("neotest").run.stop()<CR>', 'Stop the nearest test')
map('n', '<leader>st', ':lua require("neotest").summary.toggle()<CR>', 'Toggle summary window')
map('n', '<leader>sw', ':lua require("neotest").output.open({enter = true})<CR>',
    'Open output window')
