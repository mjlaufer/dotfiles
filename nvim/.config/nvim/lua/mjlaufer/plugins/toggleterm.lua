local util = require('mjlaufer.util')
local map = util.map

require('toggleterm').setup({
    size = function(term)
        if term.direction == 'horizontal' then
            return 20
        elseif term.direction == 'vertical' then
            return 80
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

vim.cmd([[cab tt ToggleTerm direction=float]])
vim.cmd([[cab tts ToggleTerm direction=horizontal]])
vim.cmd([[cab ttv ToggleTerm direction=vertical]])

-- Set up lazygit.
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = 'lazygit', direction = 'float', hidden = true })

map('n', '<leader>gl', function()
    lazygit:toggle()
end, 'lazygit')

function _G.set_terminal_keymaps()
    local opts = { buffer = 0, noremap = true, silent = true }
    map('t', '<esc>', [[<C-\><C-n>]], opts)
    map('t', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    map('t', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    map('t', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    map('t', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
