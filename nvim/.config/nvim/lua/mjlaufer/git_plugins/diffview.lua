local util = require('mjlaufer.util')

local diffview = util.prequire('diffview')
if not diffview then
    return
end

diffview.setup({use_icons = true})

local opts = {noremap = true, silent = true}

util.map('n', '<leader>gdo', ':DiffviewOpen<CR>', opts)
util.map('n', '<leader>gdc', ':DiffviewClose<CR>', opts)

util.useWhichKey({
    ['<leader>gd'] = {name = 'Git diff view', o = 'Open diff view', c = 'Close diff view'},
})
