local wk = require('which-key')

local M = {}

M.map = function(mode, lhs, rhs, desc, opts)
    local has_desc = type(desc) == 'string'
    -- Get options.
    if not has_desc and opts == nil then
        opts = desc
    end
    opts = opts or { noremap = true, silent = true }

    vim.keymap.set(mode, lhs, rhs, opts)

    -- Set whichkey.
    if has_desc and wk and mode == 'n' then
        wk.add({ mode = { 'n' }, { lhs, rhs, desc = desc } })
    end
end

M.useWhichKey = function(config)
    if not wk then
        return
    else
        wk.add(config)
    end
end

return M
