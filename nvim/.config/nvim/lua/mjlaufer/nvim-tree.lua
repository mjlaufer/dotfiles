local util = require('mjlaufer.util')

local nvim_tree = util.prequire('nvim-tree')
if not nvim_tree then
    return
end

nvim_tree.setup({view = {width = 36}})

util.map('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

util.useWhichKey({['<leader>e'] = 'Toggle file explorer'})
