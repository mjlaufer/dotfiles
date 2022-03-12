local util = require('mjlaufer.util')

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

local opts = {noremap = true, silent = true}

util.map('n', '<leader>isn', ':lua start_node_debugger()<CR>', opts)
util.map('n', '<leader>ic', ':lua require("dap").continue()<CR>', opts)
util.map('n', '<leader>ib', ':lua require("dap").toggle_breakpoint()<CR>', opts)
util.map('n', '<leader>in',
    ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
util.map('n', '<leader>im',
    ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)
util.map('n', '<leader>il', ':lua require("dap").step_into()<CR>', opts)
util.map('n', '<leader>ij', ':lua require("dap").step_over()<CR>', opts)
util.map('n', '<leader>ik', ':lua require("dap").step_out()<CR>', opts)
util.map('n', '<leader>iq', ':lua require("dap").close()<CR>', opts)

-- DAP Widgets
util.map('n', '<leader>iwu', ':lua require("dap.ui.widgets").hover()<CR>', opts)
util.map('n', '<leader>iws',
    ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.scopes).open()<CR>', opts)
util.map('n', '<leader>iwf',
    ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.frames).open()<CR>', opts)

util.useWhichKey({
    ['<leader>i'] = {
        name = 'Debugger',
        sn = 'Start Node debugger',
        c = 'Start/continue',
        b = 'Toggle breakpoint',
        n = 'Set breakpoint condition',
        m = 'Set breakpoint log message',
        l = 'Step into',
        j = 'Step over',
        k = 'Step out',
        q = 'Quit',
    },
    ['<leader>iw'] = {
        name = 'DAP Widgets',
        u = 'Show expression (under cursor)',
        s = 'Show scopes',
        f = 'Show frames',
    },
})

