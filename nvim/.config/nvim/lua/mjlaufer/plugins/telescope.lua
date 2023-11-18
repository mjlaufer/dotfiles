local util = require('mjlaufer.util')
local map = util.map

local telescope = require('telescope')

telescope.setup({
    defaults = {
        file_ignore_patterns = { 'node_modules' },
        layout_strategy = 'horizontal',
        layout_config = { horizontal = { prompt_position = 'top' } },
        sorting_strategy = 'ascending',
    },
})

util.useWhichKey({ ['<leader>f'] = { name = 'Telescope' }, ['<leader>fi'] = { name = 'Inspect' } })

map(
    'n',
    '<leader>ff',
    ':lua require("telescope.builtin").find_files({find_command={"rg", "--files", "--hidden", "-g", "!.git"}})<CR>',
    'Find files'
)
map('n', '<leader>fg', ':Telescope git_files<CR>', 'Find git files')
map('n', '<leader>fs', ':Telescope live_grep<CR>', 'Live grep')
map(
    'n',
    '<leader>fw',
    ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep for > ")})<CR>',
    'Find word'
)
map('n', '<leader>fb', ':Telescope buffers<CR>', 'List open buffers')
map('n', '<leader>fe', ':Telescope file_browser<CR>', 'File browser')
map('n', '<leader>fh', ':Telescope help_tags<CR>', 'Help tags')

-- Telescope DAP
telescope.load_extension('dap')
map('n', '<leader>fib', ':Telescope dap list_breakpoints<CR>', 'List breakpoints')
map('n', '<leader>fif', ':Telescope dap frames<CR>', 'Show frames')
map('n', '<leader>fiv', ':Telescope dap variables<CR>', 'Show variables')
