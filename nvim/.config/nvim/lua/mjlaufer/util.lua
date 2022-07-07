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
    opts = opts or {noremap = true, silent = true}
    vim.keymap.set(mode, lhs, rhs, opts)
    if (which_key and mode == 'n' and desc ~= nil) then
        which_key.register({[lhs] = {rhs, desc}})
    end
end

M.bmap = function(buffer, mode, lhs, rhs, desc, opts)
    opts = opts or {noremap = true, silent = true}
    vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
    if (which_key and mode == 'n' and desc ~= nil) then
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
