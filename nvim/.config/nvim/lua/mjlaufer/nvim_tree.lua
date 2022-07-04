local util = require('mjlaufer.util')

local nvim_tree = util.prequire('nvim-tree')
if not nvim_tree then
    return
end

nvim_tree.setup({view = {width = 36}})

util.map('n', '<leader>ee', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
util.map('n', '<leader>ef', ':NvimTreeFindFile<CR>', {noremap = true, silent = true})
util.map('n', '<leader>ec', ':NvimTreeCollapse<CR>', {noremap = true, silent = true})

util.useWhichKey({
    ['<leader>e'] = {
        name = 'Explorer (nvim-tree)',
        e = 'Toggle explorer',
        f = 'Find file',
        c = 'Collapse explorer',
    },
})
