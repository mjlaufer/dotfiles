if IS_VSCODE then
    return
end

vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', { silent = true, desc = 'Undotree' })
