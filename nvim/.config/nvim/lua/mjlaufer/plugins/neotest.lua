local map = vim.keymap.set
local neotest = require('neotest')

neotest.setup({
    adapters = {
        require('neotest-golang')({
            dap_mode = 'manual',
            dap_manual_config = {
                name = 'Debug Go tests',
                type = 'delve',
                mode = 'test',
                request = 'launch',
            },
        }),
    },
})

map('n', '<leader>td', function()
    neotest.run.run({ suite = false, strategy = 'dap' })
end, { desc = 'Debug nearest test' })
map('n', '<leader>tf', function()
    neotest.run.run(vim.fn.expand('%'))
end, { desc = 'Run test file' })
map('n', '<leader>to', function()
    neotest.output.open({ enter = true, auto_close = true })
end, { desc = 'Open test output' })
map('n', '<leader>tO', neotest.output_panel.toggle, { desc = 'Open test output panel' })
map('n', '<leader>tn', neotest.run.run, { desc = 'Run nearest test' })
map('n', '<leader>ts', function()
    neotest.run.run({ suite = true })
end, { desc = 'Run test suite' })
map('n', '<leader>tS', neotest.summary.toggle, { desc = 'Toggle test summary' })
map('n', '<leader>tt', neotest.run.stop, { desc = 'Terminate test' })
