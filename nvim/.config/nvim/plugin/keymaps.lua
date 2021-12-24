local opts = {noremap = true, silent = true}

local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Source vimrc
keymap('n', '<leader><CR>', ':so ~/dotfiles/nvim/.config/nvim/init.vim<CR>',
       {noremap = true})

-- Move selected lines up/down
keymap('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- yank/delete to clipboard [normal/visual]; put from clipboard [normal]
keymap('n', '<leader>y', '"*yy<CR>', opts)
keymap('v', '<leader>y', '"*yy<CR>', opts)
keymap('n', '<leader>d', '"*dd<CR>', opts)
keymap('v', '<leader>d', '"*dd<CR>', opts)
keymap('n', '<leader>p', '"+p<CR>', opts)
keymap('n', '<leader>P', '"+P<CR>', opts)

-- tmux-sessionizer
keymap('n', '<C-f>', ':silent !tmux neww tmux-sessionizer<CR>', opts)
