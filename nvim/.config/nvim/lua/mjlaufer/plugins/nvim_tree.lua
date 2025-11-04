local util = require('mjlaufer.util')
local map = util.map

require('nvim-tree').setup({
    view = { width = 36 },
    renderer = { group_empty = true, highlight_git = true },
    filters = { dotfiles = false, git_ignored = false },
})

util.useWhichKey({ { '<leader>e', group = 'Explorer' } })

map('n', '<leader>ee', ':NvimTreeToggle<CR>', 'Toggle')
map('n', '<leader>ef', ':NvimTreeFindFile<CR>', 'Find file')
map('n', '<leader>ec', ':NvimTreeCollapse<CR>', 'Collapse')
