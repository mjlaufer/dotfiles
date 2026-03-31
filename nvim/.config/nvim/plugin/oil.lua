if IS_VSCODE then
    return
end

require('oil').setup({
    default_file_explorer = false,
    delete_to_trash = true,
    view_options = {
        show_hidden = true,
    },
})

local function open_oil()
    require('nvim-tree.api').tree.close()
    require('oil').open()
end

vim.keymap.set('n', '-', open_oil, { desc = 'Oil' })
vim.keymap.set('n', '<leader>eo', open_oil, { desc = 'Oil' })
