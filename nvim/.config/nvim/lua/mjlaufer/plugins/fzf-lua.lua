local map = vim.keymap.set
local fzf = require('fzf-lua')

fzf.setup({ fzf_colors = true, grep = { hidden = true } })

map('n', '<leader>f<', fzf.resume, { desc = 'Resume last fzf command' })

-- Files
map('n', '<leader>fb', fzf.buffers, { desc = 'Open buffers' })
map('n', '<leader>ff', fzf.files, { desc = 'All files' })
map('n', '<leader>fg', fzf.git_files, { desc = 'Git files' })
map('n', '<leader>fo', fzf.oldfiles, { desc = 'Recently opened files' })

-- Search
map('n', '<leader>fs', fzf.live_grep, { desc = 'Live grep' })
map('n', '<leader>fw', fzf.grep_cword, { desc = 'Grep word under cursor' })
map('n', '<leader>fW', fzf.grep_cWORD, { desc = 'Grep WORD under cursor' })

-- Diagnostics
map('n', '<leader>fd', fzf.diagnostics_workspace, { desc = 'Workspace diagnostics' })

-- Vim
map('n', '<leader>fh', fzf.help_tags, { desc = 'Help tags' })
map('n', '<leader>fl', fzf.loclist, { desc = 'Location list' })
map('n', '<leader>fq', fzf.quickfix, { desc = 'Quickfix' })
