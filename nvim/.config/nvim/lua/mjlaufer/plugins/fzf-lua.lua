local util = require('mjlaufer.util')
local map = util.map

local fzf = require('fzf-lua')

fzf.setup({ fzf_colors = true, grep = { hidden = true } })

util.useWhichKey({ '<leader>f', group = 'Fzf' })

-- Files
map('n', '<leader>fb', fzf.buffers, 'Find open buffers')
map('n', '<leader>ff', fzf.files, 'Find files')
map('n', '<leader>fg', fzf.git_files, 'Find git files')

-- Search
map('n', '<leader>fs', fzf.live_grep, 'Live grep')
map('n', '<leader>fw', fzf.grep_cword, 'Grep word under cursor')
map('n', '<leader>fW', fzf.grep_cWORD, 'Grep WORD under cursor')

-- Diagnostics
map('n', '<leader>fd', fzf.diagnostics_workspace, 'Workspace diagnostics')

-- Vim
map('n', '<leader>fh', fzf.help_tags, 'Help tags')
map('n', '<leader>fl', fzf.loclist, 'Location list')
map('n', '<leader>fq', fzf.quickfix, 'Quickfix')
