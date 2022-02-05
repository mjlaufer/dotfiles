local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
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

local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

keymap('n', '<leader>ff', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>fg', ':Telescope git_files<CR>', opts)
keymap('n', '<leader>fs', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>fw',
    ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep for > ")})<CR>',
    opts)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)
keymap('n', '<leader>fe', ':Telescope file_browser<CR>', opts)
keymap('n', '<leader>fh', ':Telescope help_tags<CR>', opts)

-- Telescope DAP
telescope.load_extension('dap')

keymap('n', '<leader>dtb', ':Telescope dap list_breakpoints<CR>', opts)
keymap('n', '<leader>dtf', ':Telescope dap frames<CR>', opts)
keymap('n', '<leader>dtv', ':Telescope dap variables<CR>', opts)

require('which-key').register({
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
