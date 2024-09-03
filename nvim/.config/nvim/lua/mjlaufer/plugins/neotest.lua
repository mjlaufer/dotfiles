local util = require('mjlaufer.util')
local map = util.map

require('neotest').setup({ adapters = { require('neotest-jest')({ jestCommand = 'yarn test' }) } })

util.useWhichKey({ { '<leader>s', group = 'Spec' } })

map('n', '<leader>ss', ':lua require("neotest").run.run()<CR>', 'Run the nearest test')
map(
    'n',
    '<leader>sf',
    ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>',
    'Run the current file'
)
map(
    'n',
    '<leader>si',
    ':lua require("neotest").run.run({strategy = "dap})<CR>',
    'Debug the nearest test'
)
map('n', '<leader>sq', ':lua require("neotest").run.stop()<CR>', 'Stop the nearest test')
map('n', '<leader>st', ':lua require("neotest").summary.toggle()<CR>', 'Toggle summary window')
map(
    'n',
    '<leader>sw',
    ':lua require("neotest").output.open({enter = true})<CR>',
    'Open output window'
)
