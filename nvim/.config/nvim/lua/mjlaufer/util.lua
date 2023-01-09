local prequire = function(name)
    local ok, m = pcall(require, name)
    if not ok then
        print('Error: Could not load', name)
        return nil
    end
    return m
end

local which_key = prequire('which-key');

local M = {}

M.map = function(mode, lhs, rhs, desc, opts)
    local has_desc = type(desc) == 'string'
    -- Get options.
    if not has_desc and opts == nil then
        opts = desc
    end
    opts = opts or {noremap = true, silent = true}

    vim.keymap.set(mode, lhs, rhs, opts)

    -- Set whichkey.
    if (has_desc and which_key and mode == 'n') then
        which_key.register({[lhs] = {rhs, desc}})
    end
end

M.prequire = prequire

M.useWhichKey = function(config)
    if not which_key then
        return
    else
        which_key.register(config)
    end
end

return M
