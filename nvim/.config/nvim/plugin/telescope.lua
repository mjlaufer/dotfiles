require('telescope').setup {
    defaults = {file_ignore_patterns = {'node_modules'}}
}

require('telescope').load_extension('dap')

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
keymap('n', '<leader>dtb', ':Telescope dap list_breakpoints<CR>', opts)
keymap('n', '<leader>dtf', ':Telescope dap frames<CR>', opts)
keymap('n', '<leader>dtv', ':Telescope dap variables<CR>', opts)
