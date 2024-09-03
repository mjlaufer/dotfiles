local util = require('mjlaufer.util')
local map = util.map

require('toggleterm').setup({
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
    float_opts = { border = 'single' },
})

-- Set up lazygit.
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = 'lazygit', direction = 'float', hidden = true })

function _G.toggle_lazygit()
    lazygit:toggle()
end

util.useWhichKey({ { '<leader>t', group = 'Terminal' } })

map('n', '<Leader>tl', ':ToggleTerm direction=vertical<CR>', 'Right split')
map('n', '<Leader>tj', ':ToggleTerm direction=horizontal<CR>', 'Bottom split')
map('n', '<Leader>tu', ':ToggleTerm direction=float<CR>', 'Float')
map('n', '<Leader>tg', toggle_lazygit, 'lazygit')

function _G.set_terminal_keymaps()
    local opts = { buffer = 0, noremap = true, silent = true }
    map('t', '<esc>', [[<C-\><C-n>]], opts)
    map('t', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    map('t', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    map('t', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    map('t', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
