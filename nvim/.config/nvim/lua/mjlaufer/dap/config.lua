local util = require('mjlaufer.util')
local map = util.map

local dap = util.prequire('dap')
if not dap then
    return
end

dap.adapters.chrome = {
    type = 'executable',
    command = 'node',
    args = {vim.fn.stdpath('data') .. '/dap/vscode-chrome-debug/out/src/chromeDebug.js'},
}

local chrome_config = {
    {
        type = 'chrome',
        request = 'attach',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        port = 9222,
        webRoot = '${workspaceFolder}',
    },
}

dap.configurations.javascript = chrome_config
dap.configurations.typescript = chrome_config
dap.configurations.javascriptreact = chrome_config
dap.configurations.typescriptreact = chrome_config

-- This function allows JS/TS projects to use the Node.js debugger.
_G.start_node_debugger = function()
    dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = {vim.fn.stdpath('data') .. '/dap/vscode-node-debug2/out/src/nodeDebug.js'},
    }

    local node_config = {
        {
            name = 'Launch',
            type = 'node2',
            request = 'launch',
            program = '${file}',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
        {
            name = 'Attach to process', -- Used when starting node with the `--inspect` flag
            type = 'node2',
            request = 'attach',
            processId = require('dap.utils').pick_process,
        },
    }

    dap.configurations.javascript = node_config
    dap.configurations.typescript = node_config
    require('dap').continue()
end

vim.fn.sign_define('DapBreakpoint', {text = '🔴', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapBreakpointRejected', {text = '🔵', texthl = '', linehl = '', numhl = ''})

util.useWhichKey({['<leader>i'] = {name = 'Inspect/debug'}, ['<leader>iw'] = {name = 'DAP Widgets'}})

map('n', '<leader>isn', ':lua start_node_debugger()<CR>', 'Start Node debugger')
map('n', '<leader>ic', ':lua require("dap").continue()<CR>', 'Start/continue')
map('n', '<leader>ib', ':lua require("dap").toggle_breakpoint()<CR>', 'Toggle breakpoint')
map('n', '<leader>in',
    ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
    'Set breakpoint condition')
map('n', '<leader>im',
    ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
    'Set breakpoint log message')
map('n', '<leader>il', ':lua require("dap").step_into()<CR>', 'Step into')
map('n', '<leader>ij', ':lua require("dap").step_over()<CR>', 'Step over')
map('n', '<leader>ik', ':lua require("dap").step_out()<CR>', 'Step out')
map('n', '<leader>iq', ':lua require("dap").close()<CR>', 'Quit')

-- DAP Widgets
map('n', '<leader>iwu', ':lua require("dap.ui.widgets").hover()<CR>', 'Show expression under cursor')
map('n', '<leader>iws',
    ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.scopes).open()<CR>',
    'Show scopes')
map('n', '<leader>iwf',
    ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.frames).open()<CR>',
    'Show frames')
