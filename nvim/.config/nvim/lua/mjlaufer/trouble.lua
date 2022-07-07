local util = require('mjlaufer.util')
local map = util.map

util.useWhichKey({['<leader>x'] = {name = 'Trouble'}})

map('n', '<leader>xx', ':TroubleToggle<CR>', 'Toggle')
map('n', '<leader>xw', ':TroubleToggle workspace_diagnostics<CR>', 'Workspace diagnostics')
map('n', '<leader>xd', ':TroubleToggle document_diagnostics<CR>', 'Document diagnostics')
map('n', '<leader>xq', ':TroubleToggle quickfix<CR>', 'Quickfix list')
map('n', '<leader>xl', ':TroubleToggle loclist<CR>', 'Location list')
map('n', '<leader>xr', ':TroubleToggle lsp_references<CR>', 'LSP references')
