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

local builtin = require('telescope.builtin')

util.useWhichKey({ '<leader>f', group = 'Telescope' })

map('n', '<leader>fb', builtin.buffers, 'List open buffers')
map('n', '<leader>fd', builtin.diagnostics, 'List diagnostics')
map('n', '<leader>ff', function()
    builtin.find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' } })
end, 'Find files')
map('n', '<leader>fg', builtin.git_files, 'Find git files')
map('n', '<leader>fh', builtin.help_tags, 'Help tags')
map('n', '<leader>fn', function()
    builtin.find_files({ cwd = vim.fn.stdpath('config') })
end, 'Find in Neovim files')
map('n', '<leader>fo', function()
    builtin.live_grep({
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
    })
end, 'Find in open files')
map('n', '<leader>fs', builtin.live_grep, 'Live grep')
map('n', '<leader>fw', function()
    builtin.grep_string({ search = vim.fn.input('Grep for > ') })
end, 'Find word')
