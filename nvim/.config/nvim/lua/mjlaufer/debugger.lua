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
        webRoot = '${workspaceFolder}'
    }
}

dap.configurations.javascript = esconfig
dap.configurations.javascriptreact = esconfig
dap.configurations.typescript = esconfig
dap.configurations.typescriptreact = esconfig

vim.fn.sign_define('DapBreakpoint',
                   {text = '🔴', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapBreakpointRejected',
                   {text = '🔵', texthl = '', linehl = '', numhl = ''})

local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

keymap('n', '<leader>dc', ':lua require("dap").continue()<CR>', opts)
keymap('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<CR>', opts)
keymap('n', '<leader>dbr',
       ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
       opts)
keymap('n', '<leader>dbm',
       ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
       opts)
keymap('n', '<leader>dl', ':lua require("dap").step_into()<CR>', opts)
keymap('n', '<leader>dj', ':lua require("dap").step_over()<CR>', opts)
keymap('n', '<leader>dk', ':lua require("dap").step_out()<CR>', opts)
keymap('n', '<leader>ds', ':lua require("dap").close()<CR>', opts)

-- DAP Widgets
keymap('n', '<leader>dex', ':lua require("dap.ui.widgets").hover()<CR>', opts)
keymap('n', '<leader>dsc',
       ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.scopes).open()<CR>',
       opts)
keymap('n', '<leader>dfr',
       ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.frames).open()<CR>',
       opts)