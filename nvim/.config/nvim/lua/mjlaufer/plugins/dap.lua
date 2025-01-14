local util = require('mjlaufer.util')
local map = util.map

vim.notify = require('notify')

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

-- Install debuggers with mason.nvim.

local debuggers = {
    'codelldb',
    'delve',
    'java-debug-adapter',
    'java-test',
    'js-debug-adapter',
}

local mason_registry = require('mason-registry')

local function ensure_installed()
    for _, debugger in ipairs(debuggers) do
        local package = mason_registry.get_package(debugger)
        if not package:is_installed() then
            vim.notify('Installing ' .. debugger .. '...', vim.log.levels.INFO, { title = 'Mason' })
            package:install():once(
                'closed',
                vim.schedule_wrap(function()
                    vim.notify(
                        'Successfully installed: ' .. debugger,
                        vim.log.levels.INFO,
                        { title = 'Mason' }
                    )
                end)
            )
        end
    end
end

mason_registry.refresh(vim.schedule_wrap(ensure_installed))

-- DAP CONFIGURATIONS

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

dap.adapters.delve = function(callback, config)
    if config.mode == 'remote' and config.request == 'attach' then
        callback({
            type = 'server',
            host = config.host or '127.0.0.1',
            port = config.port or '38697',
        })
    else
        callback({
            type = 'server',
            port = '${port}',
            executable = {
                command = 'dlv',
                args = { 'dap', '-l', '127.0.0.1:${port}', '--log', '--log-output=dap' },
            },
        })
    end
end

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
        mode = 'test',
        request = 'launch',
        program = '${file}',
    },
    {
        -- For debugging all tests in a package.
        type = 'delve',
        name = 'Debug Package Tests',
        mode = 'test',
        request = 'launch',
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
        name = 'Attach to Remote',
        mode = 'remote',
        request = 'attach',
        host = '127.0.0.1', -- The host of the remote machine running delve
        port = '38697', -- The port where delve is listening on the remote machine
        showLog = true,
    },
}

-- Java

dap.configurations.java = {
    {
        type = 'java',
        name = 'Attach to Remote',
        request = 'attach',
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
        name = 'Attach to Chrome',
        request = 'attach',
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
            name = 'Debug',
            request = 'launch',
            program = '${file}',
            cwd = '${workspaceFolder}',
        },
        {
            type = 'pwa-node',
            name = 'Attach',
            request = 'attach',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
        },
    }
    dap.configurations.javascript = node_config
    dap.configurations.typescript = node_config
    require('dap').continue()
end

util.useWhichKey({
    { '<leader>d', group = 'Debug' },
    { '<leader>dw', group = 'DAP Widgets' },
})

map('n', '<leader>db', dap.toggle_breakpoint, 'Toggle breakpoint')
map('n', '<leader>dc', dap.continue, 'Start/continue')
map('n', '<leader>dj', dap.step_over, 'Step over')
map('n', '<leader>dk', dap.step_out, 'Step out')
map('n', '<leader>dl', dap.step_into, 'Step into')
map('n', '<leader>dm', function()
    require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, 'Set breakpoint log message')
map('n', '<leader>dn', function()
    require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, 'Set breakpoint condition')
map('n', '<leader>dq', dap.close, 'Quit')
map('n', '<leader>dr', dap.repl.open, 'Open REPL')
map('n', '<leader>ds', start_node_debugger, 'Start Node debugger')

-- DAP Widgets
map('n', '<leader>dwu', require('dap.ui.widgets').hover, 'Show expression under cursor')
map('n', '<leader>dws', function()
    local widgets = require('dap.ui.widgets')
    widgets.sidebar(widgets.scopes).open()
end, 'Show scopes')
map('n', '<leader>dwf', function()
    local widgets = require('dap.ui.widgets')
    widgets.sidebar(widgets.frames).open()
end, 'Show frames')

-- DAP UI
local dapui = require('dapui')
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

util.useWhichKey({ { '<leader>du', group = 'DAP UI' } })

map('n', '<leader>dui', dapui.toggle, 'Toggle UI')
map('n', '<leader>dus', function()
    dapui.toggle('sidebar')
end, 'Toggle sidebar')
map('n', '<leader>dut', function()
    dapui.toggle('tray')
end, 'Toggle tray')
