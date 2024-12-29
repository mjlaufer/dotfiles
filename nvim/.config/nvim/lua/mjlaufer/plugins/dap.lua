local util = require('mjlaufer.util')
local map = util.map

vim.fn.sign_define(
    'DapBreakpoint',
    { text = '●', texthl = 'DapBreakpointText', linehl = '', numhl = '' }
)
vim.fn.sign_define(
    'DapBreakpointRejected',
    { text = '●', texthl = 'DapBreakpointRejectedText', linehl = '', numhl = '' }
)
vim.fn.sign_define(
    'DapStopped',
    { text = '▶', texthl = 'DapStoppedText', linehl = 'DapStoppedLine', numhl = '' }
)

local dap = require('dap')

-- C

dap.adapters.codelldb = {
    type = 'server',
    host = '127.0.0.1',
    port = 13000,
    executable = {
        command = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/adapter/codelldb',
        args = { '--port', 13000 },
    },
}

dap.configurations.c = {
    {
        name = 'Debug using codelldb',
        type = 'codelldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}

-- Go

dap.adapters.delve = {
    type = 'server',
    port = '${port}',
    executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}' },
    },
}

dap.configurations.go = {
    {
        -- For debugging command-line tools or long-running applications (e.g., web servers).
        type = 'delve',
        name = 'Debug',
        request = 'launch',
        program = '${file}',
    },
    {
        -- For debugging specific tests.
        type = 'delve',
        name = 'Debug Test',
        request = 'launch',
        mode = 'test',
        program = '${file}',
    },
    {
        -- For debugging all tests in a package.
        type = 'delve',
        name = 'Debug Package Test',
        request = 'launch',
        mode = 'test',
        program = './${relativeFileDirname}',
    },
    {
        -- For attaching to a running process (e.g., a running web server).
        type = 'delve',
        name = 'Attach',
        mode = 'local',
        request = 'attach',
        processId = require('dap.utils').pick_process,
    },
    {
        -- For debugging remote processes (e.g., microservices/containers on different machines).
        type = 'delve',
        name = 'Debug Remote',
        request = 'attach',
        mode = 'remote',
        port = 38697,
    },
}

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

local js_debug_adapter_config = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
        command = 'node',
        args = {
            vim.fn.stdpath('data')
                .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
            '${port}',
        },
    },
}

dap.adapters['pwa-chrome'] = js_debug_adapter_config
dap.adapters['pwa-node'] = js_debug_adapter_config

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

util.useWhichKey({
    { '<leader>i', group = 'Inspect/debug' },
    { '<leader>iw', group = 'DAP Widgets' },
})

map('n', '<leader>ib', dap.toggle_breakpoint, 'Toggle breakpoint')
map('n', '<leader>ic', dap.continue, 'Start/continue')
map('n', '<leader>ij', dap.step_over, 'Step over')
map('n', '<leader>ik', dap.step_out, 'Step out')
map('n', '<leader>il', dap.step_into, 'Step into')
map('n', '<leader>im', function()
    require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, 'Set breakpoint log message')
map('n', '<leader>in', function()
    require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, 'Set breakpoint condition')
map('n', '<leader>iq', dap.close, 'Quit')
map('n', '<leader>ir', dap.repl.open, 'Open REPL')
map('n', '<leader>is', start_node_debugger, 'Start Node debugger')

-- DAP Widgets
map('n', '<leader>iwu', require('dap.ui.widgets').hover, 'Show expression under cursor')
map(
    'n',
    '<leader>iws',
    ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.scopes).open()<CR>',
    'Show scopes'
)
map(
    'n',
    '<leader>iwf',
    ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.frames).open()<CR>',
    'Show frames'
)

-- Virtual text
require('nvim-dap-virtual-text').setup()

util.useWhichKey({ { '<leader>it', group = 'DAP Virtual Text' } })

map('n', '<leader>itr', ':DapVirtualTextForceRefresh<CR>', 'Force refresh')
map('n', '<leader>itt', ':DapVirtualTextToggle<CR>', 'Toggle')

-- DAP UI
require('dapui').setup()

util.useWhichKey({ { '<leader>iu', group = 'DAP UI' } })

map('n', '<leader>iui', function()
    require('dapui').toggle()
end, 'Toggle UI')
map('n', '<leader>ius', function()
    require('dapui').toggle('sidebar')
end, 'Toggle sidebar')
map('n', '<leader>iut', function()
    require('dapui').toggle('tray')
end, 'Toggle tray')
