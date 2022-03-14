local util = require('mjlaufer.util')

local telescope = util.prequire('telescope')
if not telescope then
    return
end

telescope.setup({
    defaults = {
        file_ignore_patterns = {'node_modules'},
        layout_strategy = 'horizontal',
        layout_config = {horizontal = {prompt_position = 'top'}},
        sorting_strategy = 'ascending',
    },
})

local opts = {noremap = true, silent = true}

util.map('n', '<leader>ff',
    ':lua require("telescope.builtin").find_files({find_command={"rg", "--files", "--hidden", "-g", "!.git"}})<CR>',
    opts)
util.map('n', '<leader>fg', ':Telescope git_files<CR>', opts)
util.map('n', '<leader>fs', ':Telescope live_grep<CR>', opts)
util.map('n', '<leader>fw',
    ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep for > ")})<CR>',
    opts)
util.map('n', '<leader>fb', ':Telescope buffers<CR>', opts)
util.map('n', '<leader>fe', ':Telescope file_browser<CR>', opts)
util.map('n', '<leader>fh', ':Telescope help_tags<CR>', opts)

-- Telescope DAP
telescope.load_extension('dap')

util.map('n', '<leader>dtb', ':Telescope dap list_breakpoints<CR>', opts)
util.map('n', '<leader>dtf', ':Telescope dap frames<CR>', opts)
util.map('n', '<leader>dtv', ':Telescope dap variables<CR>', opts)

util.useWhichKey({
    ['<leader>f'] = {
        name = 'Telescope',
        f = 'Find files',
        g = 'Find git files',
        s = 'Live grep',
        w = 'Find word',
        b = 'List open buffers',
        e = 'File browser',
        h = 'Help tags',
    },
    ['<leader>dt'] = {
        name = 'Debugger (Telescope)',
        b = 'List breakpoints',
        f = 'Show frames',
        v = 'Show variables',
    },
})
