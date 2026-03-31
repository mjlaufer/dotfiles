if IS_VSCODE then
    return
end

require('gitlinker').setup()

local map = vim.keymap.set
map({ 'n', 'v' }, '<leader>gy', '<cmd>GitLink<CR>', { desc = 'Yank git link' })
map({ 'n', 'v' }, '<leader>gY', '<cmd>GitLink! blame<CR>', { desc = 'Open git link' })
