if IS_VSCODE then
    return
end

vim.cmd.packadd('nvim.undotree')
vim.keymap.set('n', '<leader>u', ':Undotree<CR>', { silent = true, desc = 'Undotree' })
