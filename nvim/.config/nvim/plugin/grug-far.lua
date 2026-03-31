if IS_VSCODE then
    return
end

require('grug-far').setup()

vim.keymap.set({ 'n', 'v' }, '<leader>cg', function()
    require('grug-far').open({ transient = true })
end, { desc = 'GrugFar' })
