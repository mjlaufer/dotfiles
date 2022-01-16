local opts = {noremap = true, silent = true}

local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Change sets
keymap('n', '<leader>sh', ':nohlsearch<CR>', opts)
keymap('n', '<leader>st2', ':set tabstop=2 softtabstop=2 shiftwidth=2<CR>', opts)
keymap('n', '<leader>st4', ':set tabstop=4 softtabstop=4 shiftwidth=4<CR>', opts)

-- [Visual] Move selected lines up/down
keymap('v', 'J', ':m \'>+1<CR>gv=gv', opts)
keymap('v', 'K', ':m \'<-2<CR>gv=gv', opts)

-- [Visual] Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- [Normal/Visual] yank/delete to clipboard; [Normal] put from clipboard
keymap('n', '<leader>y', '"*yy<CR>', opts)
keymap('v', '<leader>y', '"*yy<CR>', opts)
keymap('n', '<leader>d', '"*dd<CR>', opts)
keymap('v', '<leader>d', '"*dd<CR>', opts)
keymap('n', '<leader>p', '"+p<CR>', opts)
keymap('n', '<leader>P', '"+P<CR>', opts)

-- tmux-sessionizer
keymap('n', '<C-f>', ':silent !tmux neww tmux-sessionizer<CR>', opts)
