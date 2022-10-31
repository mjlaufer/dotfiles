local util = require('mjlaufer.util')

local colorizer = util.prequire('colorizer')
if not colorizer then
    return
end

colorizer.setup({
    filetypes = {
        '*',
        css = {rgb_fn = true, hsl_fn = true},
    },
})
