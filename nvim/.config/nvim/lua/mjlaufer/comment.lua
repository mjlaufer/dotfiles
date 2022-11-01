local util = require('mjlaufer.util')

local comment = util.prequire('Comment')
if not comment then
    return
end

comment.setup({
    pre_hook = function(ctx)
        -- Enable Neovim's `commentstring` for JSX.
        local ts_commentstring = util.prequire('ts_context_commentstring')
        if not ts_commentstring then
            return
        end

        local U = require('Comment.utils')
        local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'
        local location = nil

        if ctx.ctype == U.ctype.blockwise then
            location = require('ts_context_commentstring.utils').get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require('ts_context_commentstring.utils').get_visual_start_location()
        end

        return require('ts_context_commentstring.internal').calculate_commentstring {
            key = type,
            location = location,
        }
    end,
})
