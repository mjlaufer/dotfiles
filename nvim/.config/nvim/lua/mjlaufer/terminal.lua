local util = require('mjlaufer.util')

local toggleterm = util.prequire('toggleterm')
if not toggleterm then
    return
end

toggleterm.setup({
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
    terminal_mappings = true,
    persist_size = true,
    close_on_exit = true,
    shells = vim.o.shell,
    float_opts = {border = 'single'},
})

local opts = {noremap = true, silent = true}

util.map('n', '<Leader>tl', ':ToggleTerm direction=vertical<CR>', opts)
util.map('n', '<Leader>tj', ':ToggleTerm direction=horizontal<CR>', opts)
util.map('n', '<Leader>tu', ':ToggleTerm direction=float<CR>', opts)

function _G.set_terminal_keymaps()
    util.bmap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    util.bmap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    util.bmap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    util.bmap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    util.bmap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

util.useWhichKey({
    ['<leader>t'] = {name = 'Terminal', l = 'Right split', j = 'Bottom split', u = 'Float'},
})
