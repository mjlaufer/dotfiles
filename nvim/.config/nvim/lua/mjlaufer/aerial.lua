local util = require('mjlaufer.util')
local bmap = util.bmap

local aerial = util.prequire('aerial')
if not aerial then
    return
end

util.useWhichKey({['<leader>a'] = {name = 'Aerial'}})

aerial.setup({
    on_attach = function(bufnr)
        bmap(bufnr, 'n', '<leader>aa', ':AerialToggle!<CR>', 'Toggle')
        bmap(bufnr, 'n', '{', ':AerialPrev<CR>', 'Prev')
        bmap(bufnr, 'n', '}', ':AerialPrev<CR>', 'Next')
        bmap(bufnr, 'n', '[[', ':AerialPrev<CR>', 'Prev Up')
        bmap(bufnr, 'n', ']]', ':AerialPrev<CR>', 'Next Up')
    end,
})
