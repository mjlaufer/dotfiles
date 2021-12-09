local dap = require('dap')
local dap_install = require('dap-install')

dap_install.config('chrome', {})

esconfig = {
    {
        type = 'chrome',
        request = 'attach',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        port = 9222,
        webRoot = '${workspaceFolder}',
    }
}

dap.configurations.javascript = esconfig
dap.configurations.javascriptreact = esconfig
dap.configurations.typescript = esconfig
dap.configurations.typescriptreact = esconfig

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>dc', '<cmd>lua require("dap").continue()<CR>', opts) 
vim.api.nvim_set_keymap('n', '<leader>db', '<cmd>lua require("dap").toggle_breakpoint()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>lua require("dap").step_over()<CR>', opts) 
vim.api.nvim_set_keymap('n', '<leader>dj', '<cmd>lua require("dap").step_into()<CR>', opts) 
vim.api.nvim_set_keymap('n', '<leader>dk', '<cmd>lua require("dap").step_out()<CR>', opts) 
vim.api.nvim_set_keymap('n', '<leader>dbr', '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dbm', '<cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)
