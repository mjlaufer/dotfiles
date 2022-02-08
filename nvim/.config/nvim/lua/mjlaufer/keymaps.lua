local util = require('mjlaufer.util')

local opts = {noremap = true, silent = true}

-- Remap space as leader key
util.map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better window navigation
util.map('n', '<C-h>', '<C-w>h', opts)
util.map('n', '<C-j>', '<C-w>j', opts)
util.map('n', '<C-k>', '<C-w>k', opts)
util.map('n', '<C-l>', '<C-w>l', opts)

-- Navigate buffers
util.map('n', '<S-l>', ':bnext<CR>', opts)
util.map('n', '<S-h>', ':bprevious<CR>', opts)

-- Change sets
util.map('n', '<leader>sh', ':nohlsearch<CR>', opts)
util.map('n', '<leader>st2', ':set tabstop=2 softtabstop=2 shiftwidth=2<CR>', opts)
util.map('n', '<leader>st4', ':set tabstop=4 softtabstop=4 shiftwidth=4<CR>', opts)

-- [Visual] Move selected lines up/down
util.map('v', 'J', ':m \'>+1<CR>gv=gv', opts)
util.map('v', 'K', ':m \'<-2<CR>gv=gv', opts)

-- [Visual] Stay in indent mode
util.map('v', '<', '<gv', opts)
util.map('v', '>', '>gv', opts)

-- [Normal/Visual] yank/delete to clipboard; [Normal] put from clipboard
util.map('n', '<leader>y', '"*yy<CR>', opts)
util.map('v', '<leader>y', '"*yy<CR>', opts)
util.map('n', '<leader>d', '"*dd<CR>', opts)
util.map('v', '<leader>d', '"*dd<CR>', opts)
util.map('n', '<leader>p', '"+p<CR>', opts)
util.map('n', '<leader>P', '"+P<CR>', opts)

-- tmux-sessionizer
util.map('n', '<C-f>', ':silent !tmux neww tmux-sessionizer<CR>', opts)
