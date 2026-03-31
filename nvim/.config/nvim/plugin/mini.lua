require('mini.ai').setup()
require('mini.bracketed').setup()
require('mini.splitjoin').setup()

require('mini.surround').setup({
    mappings = {
        add = 'ys',
        delete = 'ds',
        replace = 'cs',
        find = '',
        find_left = '',
        highlight = '',
        update_n_lines = '',
    },
})

vim.keymap.set('n', 'yS', 'ys$', { remap = true, silent = true })
vim.keymap.set('n', 'yss', '^ys$', { remap = true, silent = true })

if IS_VSCODE then
    return
end

require('mini.bufremove').setup()

vim.keymap.set('n', '<leader>bd', function()
    require('mini.bufremove').delete(0, false)
end, { desc = 'Delete current buffer' })

local miniclue = require('mini.clue')
miniclue.setup({
    triggers = {
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },
        { mode = 'i', keys = '<C-x>' },
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },
        { mode = 'n', keys = '[' },
        { mode = 'n', keys = ']' },
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },
        { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
    },
    clues = {
        { mode = 'n', keys = '[', desc = '+prev' },
        { mode = 'n', keys = ']', desc = '+next' },
        { mode = 'n', keys = '<leader>a', desc = '+LSP' },
        { mode = 'n', keys = '<leader>b', desc = '+Buffers' },
        { mode = 'n', keys = '<leader>c', desc = '+Code' },
        { mode = 'n', keys = '<leader>d', desc = '+Debug' },
        { mode = 'n', keys = '<leader>e', desc = '+Explorer' },
        { mode = 'n', keys = '<leader>f', desc = '+Find' },
        { mode = 'n', keys = '<leader>g', desc = '+Git' },
        { mode = 'n', keys = '<leader>l', desc = '+Location list' },
        { mode = 'n', keys = '<leader>r', desc = 'Replace' },
        { mode = 'n', keys = '<leader>T', desc = 'Toggle terminal layout' },
        { mode = 'n', keys = '<leader>t', desc = '+Test' },
        { mode = 'n', keys = '<leader>u', desc = 'Undotree' },
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
    window = {
        delay = 500,
        config = {
            width = 'auto',
        },
    },
})
