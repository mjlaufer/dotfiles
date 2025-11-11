local util = require('mjlaufer.util')
local map = util.map

local fzf = require('fzf-lua')

fzf.setup({ fzf_colors = true, grep = { hidden = true } })

util.useWhichKey({ '<leader>f', group = 'Fzf' })

map('n', '<leader>f<', fzf.resume, 'Resume last fzf command')

-- Files
map('n', '<leader>fb', fzf.buffers, 'Open buffers')
map('n', '<leader>ff', fzf.files, 'All files')
map('n', '<leader>fg', fzf.git_files, 'Git files')
map('n', '<leader>fo', fzf.oldfiles, 'Recently opened files')

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
