local util = require('mjlaufer.util')

local colorizer = util.prequire('colorizer')
if not colorizer then
    return
end

colorizer.setup({
    html = {mode = 'foreground'},
    css = {rgb_fn = true, hsl_fn = true},
    'scss',
    'javascript',
    'typescript',
    'lua',
})
