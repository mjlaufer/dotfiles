require('toggleterm').setup {
    size = function(term)
        if term.direction == 'horizontal' then
            return 20
        elseif term.direction == 'vertical' then
            return 100
        end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = false,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    close_on_exit = true,
    shells = vim.o.shell,
    float_opts = {
        border = 'single',
        winblend = 0,
        highlights = {border = 'Normal', background = 'Normal'},
    },
}

local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

keymap('n', '<Leader>tl', ':ToggleTerm direction=vertical<CR>', opts)
keymap('n', '<Leader>tj', ':ToggleTerm direction=horizontal<CR>', opts)
keymap('n', '<Leader>tu', ':ToggleTerm direction=float<CR>', opts)

local bufmap = vim.api.nvim_buf_set_keymap

function _G.set_terminal_keymaps()
    bufmap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    bufmap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    bufmap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    bufmap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    bufmap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

require('which-key').register({
    ['<leader>t'] = {name = 'Terminal', l = 'Right split', j = 'Bottom split', u = 'Float'},
})
