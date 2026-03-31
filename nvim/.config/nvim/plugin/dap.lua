if IS_VSCODE then
    return
end

local util = require('mjlaufer.util')
local map = vim.keymap.set

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

util.install_mason_packages({
    'codelldb',
    'delve',
    'java-debug-adapter',
    'java-test',
    'js-debug-adapter',
})

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
    if config.request == 'attach' and config.mode == 'remote' then
        callback({
            type = 'server',
            host = config.host or '127.0.0.1',
            port = config.port or '2345',
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
        type = 'delve',
        name = 'Debug',
        request = 'launch',
        program = '${file}',
    },
    {
        type = 'delve',
        name = 'Debug Tests',
        request = 'launch',
        mode = 'test',
        program = './${relativeFileDirname}',
    },
    {
        type = 'delve',
        name = 'Attach',
        request = 'attach',
        mode = 'remote',
        host = '127.0.0.1',
        port = '2345',
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

dap.adapters.chrome = js_debug_adapter_config
dap.adapters['pwa-chrome'] = js_debug_adapter_config
dap.adapters.node = js_debug_adapter_config
dap.adapters['pwa-node'] = js_debug_adapter_config

local chrome_config = {
    {
        type = 'pwa-chrome',
        name = 'Attach to Chrome',
        request = 'attach',
        program = '${file}',
        port = 9222,
        cwd = '${workspaceFolder}',
    },
}

local node_config = {
    {
        type = 'pwa-node',
        name = 'Attach',
        request = 'attach',
        port = 9229,
        cwd = '${workspaceFolder}',
    },
}

dap.configurations.javascript = vim.deepcopy(chrome_config)
dap.configurations.typescript = vim.deepcopy(chrome_config)
dap.configurations.javascriptreact = vim.deepcopy(chrome_config)
dap.configurations.typescriptreact = vim.deepcopy(chrome_config)

-- Load VS Code launch configurations.
local function load_vscode_launch_configs()
    local launch_json_path = vim.fn.findfile('.vscode/launch.json', vim.fn.getcwd() .. ';')
    if launch_json_path == '' then
        return
    end

    local file = io.open(launch_json_path, 'r')
    if not file then
        return
    end

    local content = file:read('*all')
    file:close()

    local success, launch_config = pcall(vim.json.decode, content)
    if not success or not launch_config.configurations then
        return
    end

    local type_map = {
        lldb = { adapter = 'codelldb', filetypes = { 'c' } },
        codelldb = { adapter = 'codelldb', filetypes = { 'c' } },
        cppdbg = { adapter = 'codelldb', filetypes = { 'c' } },
        go = { adapter = 'delve', filetypes = { 'go' } },
        java = { adapter = 'java', filetypes = { 'java' } },
        chrome = {
            adapter = 'pwa-chrome',
            filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
        },
        ['pwa-chrome'] = {
            adapter = 'pwa-chrome',
            filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
        },
        node = {
            adapter = 'pwa-node',
            filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
        },
        ['pwa-node'] = {
            adapter = 'pwa-node',
            filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
        },
    }

    for _, config in ipairs(launch_config.configurations) do
        local mapping = type_map[config.type]
        if mapping then
            local dap_config = vim.deepcopy(config)
            dap_config.type = mapping.adapter
            dap_config.name = '[launch.json] ' .. (dap_config.name or 'Unnamed')

            for _, ft in ipairs(mapping.filetypes) do
                dap.configurations[ft] = dap.configurations[ft] or {}
                table.insert(dap.configurations[ft], dap_config)
            end
        end
    end
end

load_vscode_launch_configs()

_G.start_node_debugger = function()
    dap.configurations.javascript = vim.deepcopy(node_config)
    dap.configurations.typescript = vim.deepcopy(node_config)
    load_vscode_launch_configs()
    require('dap').continue()
end

map('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
map('n', '<leader>dc', dap.continue, { desc = 'Start/continue' })
map('n', '<leader>dj', dap.step_over, { desc = 'Step over' })
map('n', '<leader>dk', dap.step_out, { desc = 'Step out' })
map('n', '<leader>dl', dap.step_into, { desc = 'Step into' })
map('n', '<leader>dm', function()
    require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, { desc = 'Set breakpoint log message' })
map('n', '<leader>dn', function()
    require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'Set breakpoint condition' })
map('n', '<leader>dq', dap.terminate, { desc = 'Quit' })
map('n', '<leader>dr', dap.repl.open, { desc = 'Open REPL' })
map('n', '<leader>ds', start_node_debugger, { desc = 'Start Node debugger' })

-- DAP Widgets
map('n', '<leader>dwu', require('dap.ui.widgets').hover, { desc = 'Show expression under cursor' })
map('n', '<leader>dws', function()
    local widgets = require('dap.ui.widgets')
    widgets.sidebar(widgets.scopes).open()
end, { desc = 'Show scopes' })
map('n', '<leader>dwf', function()
    local widgets = require('dap.ui.widgets')
    widgets.sidebar(widgets.frames).open()
end, { desc = 'Show frames' })

-- DAP UI
require('nvim-dap-virtual-text').setup()

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

map('n', '<leader>dui', dapui.toggle, { desc = 'Toggle UI' })
map('n', '<leader>dus', function()
    dapui.toggle('sidebar')
end, { desc = 'Toggle sidebar' })
map('n', '<leader>dut', function()
    dapui.toggle('tray')
end, { desc = 'Toggle tray' })
