local util = require('mjlaufer.util')

local dap = util.prequire('dap')
local dap_install = util.prequire('dap-install')
if not dap or not dap_install then
    return
end

dap_install.config('chrome', {})

local esconfig = {
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

dap.configurations.javascript = esconfig
dap.configurations.javascriptreact = esconfig
dap.configurations.typescript = esconfig
dap.configurations.typescriptreact = esconfig

vim.fn.sign_define('DapBreakpoint', {text = '🔴', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapBreakpointRejected', {text = '🔵', texthl = '', linehl = '', numhl = ''})

local opts = {noremap = true, silent = true}

util.map('n', '<leader>ic', ':lua require("dap").continue()<CR>', opts)
util.map('n', '<leader>ib', ':lua require("dap").toggle_breakpoint()<CR>', opts)
util.map('n', '<leader>in',
    ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
util.map('n', '<leader>im',
    ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)
util.map('n', '<leader>il', ':lua require("dap").step_into()<CR>', opts)
util.map('n', '<leader>ij', ':lua require("dap").step_over()<CR>', opts)
util.map('n', '<leader>ik', ':lua require("dap").step_out()<CR>', opts)
util.map('n', '<leader>is', ':lua require("dap").close()<CR>', opts)

-- DAP Widgets
util.map('n', '<leader>iwu', ':lua require("dap.ui.widgets").hover()<CR>', opts)
util.map('n', '<leader>iws',
    ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.scopes).open()<CR>', opts)
util.map('n', '<leader>iwf',
    ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.frames).open()<CR>', opts)

util.useWhichKey({
    ['<leader>i'] = {
        name = 'Debugger',
        c = 'Start/continue',
        b = 'Toggle breakpoint',
        n = 'Set breakpoint condition',
        m = 'Set breakpoint log message',
        l = 'Step into',
        j = 'Step over',
        k = 'Step out',
        s = 'Close',
    },
    ['<leader>iw'] = {
        name = 'Debugger UI',
        u = 'Show expression (under cursor)',
        s = 'Show scopes',
        f = 'Show frames',
    },
})
