local util = require('mjlaufer.util')
local map = util.map

local neotest = require('neotest')

neotest.setup({
    adapters = {
        require('neotest-golang'),
    },
})

util.useWhichKey({ { '<leader>t', group = 'Test' } })

map('n', '<leader>tf', function()
    neotest.run.run(vim.fn.expand('%'))
end, 'Run test file')
map('n', '<leader>to', function()
    neotest.output.open({ enter = true, auto_close = true })
end, 'Open test output')
map('n', '<leader>tO', neotest.output_panel.toggle, 'Open test output panel')
map('n', '<leader>tn', neotest.run.run, 'Run nearest test')
map('n', '<leader>ts', function()
    neotest.run.run({ suite = true })
end, 'Run test suite')
map('n', '<leader>tS', neotest.summary.toggle, 'Toggle test summary')
map('n', '<leader>tt', neotest.run.stop, 'Terminate test')
