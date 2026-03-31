if IS_VSCODE then
    return
end

require('fzf-lua').setup({
    fzf_colors = true,
    grep = {
        hidden = true,
        RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
        rg_opts = '--column --line-number --no-heading --color=always --max-columns=4096 --glob "!.git/" -e',
    },
    keymap = {
        fzf = { ['ctrl-q'] = 'select-all+accept' },
    },
})

local map = vim.keymap.set
map('n', '<leader>f<', '<cmd>FzfLua resume<CR>', { desc = 'Resume last fzf command' })
map('n', '<leader>fb', '<cmd>FzfLua buffers<CR>', { desc = 'Open buffers' })
map('n', '<leader>ff', '<cmd>FzfLua files<CR>', { desc = 'All files' })
map('n', '<leader>fg', '<cmd>FzfLua git_files<CR>', { desc = 'Git files' })
map('n', '<leader>fo', '<cmd>FzfLua oldfiles<CR>', { desc = 'Recently opened files' })
map('n', '<leader>fs', '<cmd>FzfLua live_grep<CR>', { desc = 'Live grep' })
map('n', '<leader>fw', '<cmd>FzfLua grep_cword<CR>', { desc = 'Grep word under cursor' })
map('n', '<leader>fW', '<cmd>FzfLua grep_cWORD<CR>', { desc = 'Grep WORD under cursor' })
map('n', '<leader>fd', '<cmd>FzfLua diagnostics_workspace<CR>', { desc = 'Workspace diagnostics' })
map('n', '<leader>fh', '<cmd>FzfLua help_tags<CR>', { desc = 'Help tags' })
map('n', '<leader>fl', '<cmd>FzfLua loclist<CR>', { desc = 'Location list' })
map('n', '<leader>fq', '<cmd>FzfLua quickfix<CR>', { desc = 'Quickfix' })
