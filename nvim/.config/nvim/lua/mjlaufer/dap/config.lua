local util = require('mjlaufer.util')
local map = util.map

local dap = util.prequire('dap')
if not dap then
    return
end

-- JavaScript and TypeScript
local dap_js = util.prequire('dap-vscode-js')
if dap_js then
    dap_js.setup({
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
end

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
