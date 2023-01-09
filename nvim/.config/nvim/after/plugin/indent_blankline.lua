local util = require('mjlaufer.util')

local indent_blankline = util.prequire('indent_blankline')
if not indent_blankline then
    return
end

indent_blankline.setup({show_current_context = true})
