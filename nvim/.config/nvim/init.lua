require('mjlaufer.sets')
require('mjlaufer.keymaps')
require('mjlaufer.plugins')
require('mjlaufer.editorconfig')
require('mjlaufer.colors')
require('mjlaufer.telescope')
require('mjlaufer.autopairs')
require('mjlaufer.comment')
require('mjlaufer.lsp')
require('mjlaufer.cmp')
require('mjlaufer.git_plugins')
require('mjlaufer.dap')
require('mjlaufer.terminal')
require('mjlaufer.nvim_tree')
require('mjlaufer.lualine')
require('mjlaufer.colorizer')

function _G.ReloadConfig()
    for name, _ in pairs(package.loaded) do
        if name:match('^mjlaufer') then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
end

vim.api.nvim_set_keymap('n', '<leader><CR>', '<Cmd>lua ReloadConfig()<CR>',
    {silent = true, noremap = true})

