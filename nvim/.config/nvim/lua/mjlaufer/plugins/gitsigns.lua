local map = vim.keymap.set

require('gitsigns').setup({
    current_line_blame = true,
    current_line_blame_opts = { delay = 500 },
    current_line_blame_formatter = '    <author>, <author_time:%m/%d/%y> - <summary>',
    gh = true,
})

map(
    'n',
    '<leader>gb',
    ':Gitsigns toggle_current_line_blame<CR>',
    { silent = true, desc = 'Toggle line blame' }
)
map('n', '[g', ':Gitsigns prev_hunk<CR>', { silent = true, desc = 'Previous hunk' })
map('n', ']g', ':Gitsigns next_hunk<CR>', { silent = true, desc = 'Next hunk' })
map('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', { silent = true, desc = 'Preview hunk' })
map('n', '<leader>gr', ':Gitsigns reset_hunk<CR>', { silent = true, desc = 'Reset hunk' })
map('n', '<leader>gs', ':Gitsigns stage_hunk<CR>', { silent = true, desc = 'Stage hunk' })
