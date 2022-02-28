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

-- Change options
util.map('n', '<leader>oh', ':nohlsearch<CR>', opts)
util.map('n', '<leader>ot2', ':set tabstop=2 softtabstop=2 shiftwidth=2<CR>', opts)
util.map('n', '<leader>ot4', ':set tabstop=4 softtabstop=4 shiftwidth=4<CR>', opts)

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

-- Run current spec file with plenary.test_harness
util.map('n', '<leader>s', '<Plug>PlenaryTestFile', {noremap = false, silent = false})

-- Reload config
vim.api.nvim_set_keymap('n', '<leader><CR>', ':lua RELOAD_CONFIG()<CR>',
    {silent = true, noremap = true})

util.useWhichKey({
    ['<leader>'] = {
        o = {
            name = 'Options',
            h = 'Remove search highlights',
            ['2'] = 'Set tab to 2 spaces',
            ['4'] = 'Set tab to 4 spaces',
        },
        s = {name = 'Spec'},
    },
})
