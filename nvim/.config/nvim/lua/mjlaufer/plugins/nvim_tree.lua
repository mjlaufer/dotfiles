local map = vim.keymap.set

require('nvim-tree').setup({
    view = { width = 36 },
    renderer = { group_empty = true, highlight_git = true },
    filters = { dotfiles = false, git_ignored = false },
})

map('n', '<leader>ee', ':NvimTreeToggle<CR>', { silent = true, desc = 'Toggle' })
map('n', '<leader>ef', ':NvimTreeFindFile<CR>', { silent = true, desc = 'Find file' })
map('n', '<leader>ec', ':NvimTreeCollapse<CR>', { silent = true, desc = 'Collapse' })
