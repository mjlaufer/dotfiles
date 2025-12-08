local map = vim.keymap.set

map('n', '<leader>go', ':DiffviewOpen<CR>', { silent = true, desc = 'Open diff' })
map('n', '<leader>gc', ':DiffviewClose<CR>', { silent = true, desc = 'Close diff' })
