local map = require('mjlaufer.util').map
local useWhichKey = require('mjlaufer.util').useWhichKey

useWhichKey({
    { '<leader>d', group = 'Diagnostics' },
    { '<leader>o', group = 'Options' },
    { '<leader>p', group = 'Plenary' },
})

-- Set <space> to no-op since we use it for our leader.
map('', '<Space>', '<Nop>')

-- Diagnostics
map('n', '<leader>dl', vim.diagnostic.setloclist, 'Show diagnostics in location list')
map('n', '<leader>df', vim.diagnostic.open_float, 'Show diagnostics')
map('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')

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

-- Improve split navigation (See `:help wincmd`).
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Change options.
map('n', '<esc>', ':nohlsearch<CR>', 'Remove search highlights')
map('n', '<leader>o2', ':set tabstop=2 softtabstop=2 shiftwidth=2<CR>', 'Set tab to 2 spaces')
map('n', '<leader>o4', ':set tabstop=4 softtabstop=4 shiftwidth=4<CR>', 'Set tab to 4 spaces')
map('n', '<leader>os', ':set spell<CR>', 'Set spell checking')

-- Better movement for wrapped lines
map('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
map('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- Move selected lines up/down.
map('x', 'J', ":m '>+1<CR>gv=gv")
map('x', 'K', ":m '<-2<CR>gv=gv")

-- Stay in indent mode.
map('x', '<', '<gv')
map('x', '>', '>gv')

-- Put yanked/deleted content over selection; keep content in unnamed register.
map('x', '<leader>p', '"_dP')

-- Search in current selection.
map('x', '/', '<esc>/\\%V', { noremap = true })

-- Search for current selection.
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

-- Always use the same flags when repeating a substitution command.
map('n', '&', ':&&<CR>')
map('x', '&', ':&&<CR>')

-- tmux-sessionizer
map('n', '<c-s>', ':silent !tmux neww tmux-sessionizer<cr>')

-- Run current spec file with plenary.test_harness.
map('n', '<leader>ps', '<Plug>PlenaryTestFile', 'Run current spec file')

-- Reload config.
map('n', '<leader><CR>', RELOAD_CONFIG)
