local dap = require('dap')
local dap_install = require('dap-install')

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

local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

keymap('n', '<leader>ic', ':lua require("dap").continue()<CR>', opts)
keymap('n', '<leader>ib', ':lua require("dap").toggle_breakpoint()<CR>', opts)
keymap('n', '<leader>in',
    ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
keymap('n', '<leader>im',
    ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)
keymap('n', '<leader>il', ':lua require("dap").step_into()<CR>', opts)
keymap('n', '<leader>ij', ':lua require("dap").step_over()<CR>', opts)
keymap('n', '<leader>ik', ':lua require("dap").step_out()<CR>', opts)
keymap('n', '<leader>is', ':lua require("dap").close()<CR>', opts)

-- DAP Widgets
keymap('n', '<leader>iwu', ':lua require("dap.ui.widgets").hover()<CR>', opts)
keymap('n', '<leader>iws',
    ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.scopes).open()<CR>', opts)
keymap('n', '<leader>iwf',
    ':lua local widgets=require("dap.ui.widgets");widgets.sidebar(widgets.frames).open()<CR>', opts)

require('which-key').register({
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
