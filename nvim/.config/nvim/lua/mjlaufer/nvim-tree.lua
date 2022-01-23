local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
    return
end

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

nvim_tree.setup({view = {width = 36}})
