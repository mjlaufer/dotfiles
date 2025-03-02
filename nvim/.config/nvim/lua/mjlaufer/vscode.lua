local vscode = require('vscode')

vim.notify = vscode.notify

-- Useful VS Code shortcuts:
-- Cmd + ,           Open settings
-- Cmd + K + S       View keyboard shortcuts
-- Cmd + Shift + D   Toggle focus between debugger and editor
-- Cmd + Shift + E   Toggle focus between explorer and editor
-- Cmd + Shift + F   Toggle focus between search and editor
-- Cmd + Shift + X   Toggle focus between extension and editor
-- Cmd + 0           Focus on sidebar
-- Cmd + B           Toggle sidebar
-- Cmd + Opt + B     Toggle secondary sidebar
-- Cmd + J           Toggle bottom panel
-- Ctrl + `          Toggle terminal
-- Ctrl + Esc        Focus on editor from terminal
-- Ctrl + Shift + G  Toggle focus between source control and editor

-- Set vim-sneak colors to Flashy theme.
vim.cmd([[
    hi Sneak guifg=#1b1b1b guibg=#f998c7
    hi SneakScope guibg=#353535
]])

local function vscode_notify(cmd)
    return function()
        vim.fn.VSCodeNotify(cmd)
    end
end

vim.g.mapleader = ' '

-- Improve split navigation
vim.keymap.set('n', '<C-h>', vscode_notify('workbench.action.focusLeftGroup'))
vim.keymap.set('n', '<C-l>', vscode_notify('workbench.action.focusRightGroup'))
vim.keymap.set('n', '<C-j>', vscode_notify('workbench.action.focusBelowGroup'))
vim.keymap.set('n', '<C-k>', vscode_notify('workbench.action.focusAboveGroup'))

-- Sidebar / file explorer
vim.keymap.set(
    'n',
    '<leader>ee',
    vscode_notify('workbench.action.toggleSidebarVisibility'),
    { desc = 'Toggle sidebar' }
)
vim.keymap.set(
    'n',
    '<leader>ef',
    vscode_notify('workbench.view.explorer'),
    { desc = 'Toggle explorer' }
)

-- Finder
vim.keymap.set(
    'n',
    '<leader>ff',
    vscode_notify('workbench.action.quickOpen'),
    { desc = 'Find files' }
)
vim.keymap.set(
    'n',
    '<leader>fh',
    vscode_notify('workbench.action.showCommands'),
    { desc = 'Command Palette' }
)
vim.keymap.set(
    'n',
    '<leader>fs',
    vscode_notify('workbench.action.findInFiles'),
    { desc = 'Find in files' }
)

-- LSP actions
vim.keymap.set(
    'n',
    'gd',
    vscode_notify('editor.action.revealDefinition'),
    { desc = 'Go to definition' }
)
vim.keymap.set(
    'n',
    'gI',
    vscode_notify('editor.action.goToImplementation'),
    { desc = 'Go to implementation' }
)
vim.keymap.set(
    'n',
    'gr',
    vscode_notify('editor.action.goToReferences'),
    { desc = 'Go to references' }
)
vim.keymap.set('n', 'K', vscode_notify('editor.action.showHover'), { desc = 'Show hover' })
vim.keymap.set(
    'n',
    '<leader>aa',
    vscode_notify('editor.action.quickFix'),
    { desc = 'Code actions' }
)
vim.keymap.set('n', '<leader>ar', vscode_notify('editor.action.rename'), { desc = 'Rename symbol' })
vim.keymap.set(
    'n',
    '<leader>cf',
    vscode_notify('editor.action.formatDocument'),
    { desc = 'Format' }
)

-- Diagnostics
vim.keymap.set(
    'n',
    '<leader>ld',
    vscode_notify('workbench.actions.view.problems'),
    { desc = 'Show diagnostics' }
)
vim.keymap.set(
    'n',
    '[d',
    vscode_notify('editor.action.marker.prev'),
    { desc = 'Previous diagnostic' }
)
vim.keymap.set('n', ']d', vscode_notify('editor.action.marker.next'), { desc = 'Next diagnostic' })

-- Git
vim.keymap.set('n', '<leader>go', vscode_notify('workbench.view.scm'), { desc = 'Git' })
vim.keymap.set(
    'n',
    '<leader>gb',
    vscode_notify('gitlens.toggleFileBlame'),
    { desc = 'Toggle git blame' }
)
vim.keymap.set(
    'n',
    ']c',
    vscode_notify('workbench.action.editor.nextChange'),
    { desc = 'Next change' }
)
vim.keymap.set(
    'n',
    '[c',
    vscode_notify('workbench.action.editor.previousChange'),
    { desc = 'Previous change' }
)

-- Debug/Test
vim.keymap.set(
    'n',
    '<leader>db',
    vscode_notify('editor.debug.action.toggleBreakpoint'),
    { desc = 'Toggle breakpoint' }
)
vim.keymap.set(
    'n',
    '<leader>dc',
    vscode_notify('workbench.action.debug.continue'),
    { desc = 'Continue' }
)
vim.keymap.set('n', '<leader>ds', vscode_notify('workbench.action.debug.run'), { desc = 'Start' })
vim.keymap.set(
    'n',
    '<leader>tf',
    vscode_notify('workbench.action.testing.runAll'),
    { desc = 'Run All Tests' }
)
