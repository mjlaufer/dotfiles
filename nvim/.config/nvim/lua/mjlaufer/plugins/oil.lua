local map = vim.keymap.set

require('oil').setup({
    default_file_explorer = false,
    delete_to_trash = true,
    view_options = {
        show_hidden = true,
    },
})

function _G.open_oil()
    require('nvim-tree.api').tree.close()
    require('oil').open()
end

map('n', '<leader>eo', open_oil, { desc = 'Oil' })
map('n', '-', open_oil, { desc = 'Oil' })
