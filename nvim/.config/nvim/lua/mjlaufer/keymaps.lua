local map = require('mjlaufer.util').map
local useWhichKey = require('mjlaufer.util').useWhichKey

useWhichKey({
    { '<leader>c', group = 'Quickfix list' },
    { '<leader>l', group = 'Location list' },
    { '<leader>o', group = 'Options' },
    { '<leader>p', group = 'Plenary' },
})

-- Remap space as leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
map('', '<Space>', '<Nop>')

-- Open quickfix and location lists.
map('n', '<leader>co', ':copen<CR>', 'Open quickfix list')
map('n', '<leader>cc', ':ccl<CR>', 'Close quickfix list')
map('n', '<leader>lo', ':lopen<CR>', 'Open location list')
map('n', '<leader>lc', ':lcl<CR>', 'Close location list')

-- Keep cursor line centered during page/search/list movement.
map('n', '<C-f>', '<C-f>zz')
map('n', '<C-b>', '<C-b>zz')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '<leader>cn', ':cnext<CR>zz', 'Go to next item')
map('n', '<leader>cp', ':cprev<CR>zz', 'Go to prev item')
map('n', '<leader>ln', ':lnext<CR>zz', 'Go to next item')
map('n', '<leader>lp', ':lprev<CR>zz', 'Go to prev item')

-- Better split navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Change options.
map('n', '<leader>oh', ':nohlsearch<CR>', 'Remove search highlights')
map('n', '<leader>o2', ':set tabstop=2 softtabstop=2 shiftwidth=2<CR>', 'Set tab to 2 spaces')
map('n', '<leader>o4', ':set tabstop=4 softtabstop=4 shiftwidth=4<CR>', 'Set tab to 4 spaces')
map('n', '<leader>os', ':set spell<CR>', 'Set spell checking')

-- Better movement for wrapped lines
map('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
map('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- [Visual] Move selected lines up/down.
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- [Visual] Stay in indent mode.
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Highlight on yank.
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- [Normal/Visual] Yank/delete to clipboard.
map({ 'n', 'v' }, '<leader>y', '"+yy<CR>')
map({ 'n', 'v' }, '<leader>d', '"+dd<CR>')
-- [Normal] Put from clipboard.
map('n', '<leader>p', '"+p<CR>')
map('n', '<leader>P', '"+P<CR>')
-- [Visual] Put yanked/deleted content over selection; keep content in unnamed register.
map('x', '<leader>p', '"_dP')

-- [Visual] Search in current selection.
map('x', '/', '<esc>/\\%V', { noremap = true })

-- [Visual] Search for current selection.
map('x', '*', ':lua VSetSearch("/")<CR>/<C-r>=@/<CR><CR>')
map('x', '#', ':lua VSetSearch("?")<CR>?<C-r>=@/<CR><CR>')

function _G.VSetSearch(search_cmd)
    vim.cmd([[
        let temp = @s
        norm! gv"sy
    ]])
    if search_cmd == '/' then
        vim.cmd([[ let @/ = '\V' . substitute(escape(@s, '/' . '\'), '\n', '\\n', 'g') ]])
    elseif search_cmd == '?' then
        vim.cmd([[ let @/ = '\V' . substitute(escape(@s, '?' . '\'), '\n', '\\n', 'g') ]])
    end
    vim.cmd([[ let @s = temp ]])
end

-- Substitute word under cursor.
map('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { noremap = true })

-- [Normal/Visual] Always use the same flags when repeating a substitution command.
map({ 'n', 'x' }, '&', ':&&<CR>')

-- tmux-sessionizer
map('n', '<c-s>', ':silent !tmux neww tmux-sessionizer<cr>')

-- Run current spec file with plenary.test_harness.
map('n', '<leader>ps', '<Plug>PlenaryTestFile', 'Run current spec file')

-- Reload config.
map('n', '<leader><CR>', RELOAD_CONFIG)
