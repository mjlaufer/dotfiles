local util = require('mjlaufer.util')
local map = util.map

local dap = require('dap')

-- Java
dap.configurations.java = {
    {
        type = 'java',
        request = 'attach',
        name = 'Debug (Attach) - Remote',
        hostName = '127.0.0.1',
        port = 5005,
    },
}

-- JavaScript and TypeScript
require('dap-vscode-js').setup({
    debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
    adapters = {'pwa-node', 'pwa-chrome'},
})

local chrome_config = {
    {
        type = 'pwa-chrome',
        request = 'attach',
        name = 'Attach to Chrome',
        program = '${file}',
        cwd = '${workspaceFolder}',
        port = 9222,
    },
}
dap.configurations.javascript = chrome_config
dap.configurations.typescript = chrome_config
dap.configurations.javascriptreact = chrome_config
dap.configurations.typescriptreact = chrome_config

-- This function allows JS/TS projects to use the Node.js debugger.
_G.start_node_debugger = function()
    local node_config = {
        {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch',
            program = '${file}',
            cwd = '${workspaceFolder}',
        },
        {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach to process', -- Used when starting node with the `--inspect` flag
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
        },
    }
    dap.configurations.javascript = node_config
    dap.configurations.typescript = node_config
    require('dap').continue()
end

vim.fn.sign_define('DapBreakpoint', {text = '🔴', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapBreakpointRejected', {text = '🔵', texthl = '', linehl = '', numhl = ''})

util.useWhichKey({['<leader>i'] = {name = 'Inspect/debug'}, ['<leader>iw'] = {name = 'DAP Widgets'}})

map('n', '<leader>isn', start_node_debugger, 'Start Node debugger')
map('n', '<leader>ic', dap.continue, 'Start/continue')
map('n', '<leader>ib', dap.toggle_breakpoint, 'Toggle breakpoint')
map('n', '<leader>in',
    ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
    'Set breakpoint condition')
map('n', '<leader>im',
    ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
    'Set breakpoint log message')
map('n', '<leader>il', dap.step_into, 'Step into')
map('n', '<leader>ij', dap.step_over, 'Step over')
map('n', '<leader>ik', dap.step_out, 'Step out')
map('n', '<leader>iq', dap.close, 'Quit')

-- DAP Widgets
map('n', '<leader>iwu', require('dap.ui.widgets').hover, 'Show expression under cursor')
map('n', '<leader>iws',
    ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.scopes).open()<CR>',
    'Show scopes')
map('n', '<leader>iwf',
    ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.frames).open()<CR>',
    'Show frames')
