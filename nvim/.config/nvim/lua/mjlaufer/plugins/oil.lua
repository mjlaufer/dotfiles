local util = require('mjlaufer.util')
local map = util.map

require('oil').setup({
    default_file_explorer = false,
    delete_to_trash = true,
    trash_command = 'trash',
    view_options = {
        show_hidden = true,
    },
})

function _G.open_oil()
    require('nvim-tree.api').tree.close()
    require('oil').open()
end

util.useWhichKey({ ['<leader>e'] = { name = 'Explorer' } })

map('n', '<leader>eo', open_oil, 'Oil')
map('n', '-', open_oil, 'Oil')
