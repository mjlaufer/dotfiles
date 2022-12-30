local map = require('mjlaufer.util').map
local useWhichKey = require('mjlaufer.util').useWhichKey

useWhichKey({['<leader>'] = {o = {name = 'Options'}, p = {name = 'Plenary'}}})

-- Remap space as leader key
map('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Change options
map('n', '<leader>oh', ':nohlsearch<CR>', 'Remove search highlights')
map('n', '<leader>o2', ':set tabstop=2 softtabstop=2 shiftwidth=2<CR>', 'Set tab to 2 spaces')
map('n', '<leader>o4', ':set tabstop=4 softtabstop=4 shiftwidth=4<CR>', 'Set tab to 4 spaces')

-- [Visual] Move selected lines up/down
map('v', 'J', ':m \'>+1<CR>gv=gv')
map('v', 'K', ':m \'<-2<CR>gv=gv')

-- [Visual] Stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- [Normal/Visual] yank/delete to clipboard; [Normal] put from clipboard
map('n', '<leader>y', '"+yy<CR>')
map('v', '<leader>y', '"+yy<CR>')
map('n', '<leader>d', '"+dd<CR>')
map('v', '<leader>d', '"+dd<CR>')
map('n', '<leader>p', '"+p<CR>')
map('n', '<leader>P', '"+P<CR>')

-- [Visual] Search in current selection
map('x', '/', '<esc>/\\%V')

-- [Visual] Search for current selection
map('x', '*', ':lua VSetSearch("/")<CR>/<C-r>=@/<CR><CR>')
map('x', '#', ':lua VSetSearch("?")<CR>?<C-r>=@/<CR><CR>')

function _G.VSetSearch(search_cmd)
    vim.cmd [[
        let temp = @s
        norm! gv"sy
    ]]
    if search_cmd == '/' then
        vim.cmd [[ let @/ = '\V' . substitute(escape(@s, '/' . '\'), '\n', '\\n', 'g') ]]
    elseif search_cmd == '?' then
        vim.cmd [[ let @/ = '\V' . substitute(escape(@s, '?' . '\'), '\n', '\\n', 'g') ]]
    end
    vim.cmd [[ let @s = temp ]]
end

-- [Normal/Visual] Always use the same flags when repeating a substitution command
map('n', '&', ':&&<CR>')
map('x', '&', ':&&<CR>')

-- tmux-sessionizer
map('n', '<c-s>', ':silent !tmux neww tmux-sessionizer<cr>')

-- Run current spec file with plenary.test_harness
map('n', '<leader>ps', '<Plug>PlenaryTestFile', 'Run current spec file')

-- Reload config
map('n', '<leader><CR>', RELOAD_CONFIG)
