local util = require('mjlaufer.util')
local bmap = util.bmap

local aerial = util.prequire('aerial')
if not aerial then
    return
end

util.useWhichKey({['<leader>a'] = {name = 'Aerial'}})

aerial.setup({
    on_attach = function(bufnr)
        bmap(bufnr, 'n', '<leader>a', ':AerialToggle!<CR>', 'Aerial')
    end,
})
