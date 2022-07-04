local util = require('mjlaufer.util')

local nvim_tree = util.prequire('nvim-tree')
if not nvim_tree then
    return
end

nvim_tree.setup({view = {width = 36}})

local opts = {noremap = true, silent = true}

util.map('n', '<leader>ee', ':NvimTreeToggle<CR>', opts)
util.map('n', '<leader>ef', ':NvimTreeFindFile<CR>', opts)
util.map('n', '<leader>ec', ':NvimTreeCollapse<CR>', opts)

util.useWhichKey({
    ['<leader>e'] = {
        name = 'Explorer (nvim-tree)',
        e = 'Toggle explorer',
        f = 'Find file',
        c = 'Collapse explorer',
    },
})
