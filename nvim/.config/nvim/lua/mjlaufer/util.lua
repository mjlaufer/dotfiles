local M = {}

M.map = vim.api.nvim_set_keymap

M.bmap = vim.api.nvim_buf_set_keymap

M.prequire = function(name)
    local ok, m = pcall(require, name)
    if not ok then
        print('Error: Could not load', name)
        return nil
    end
    return m
end

M.useWhichKey = function(config)
    local which_key = M.prequire('which-key')
    if not which_key then
        return
    else
        which_key.register(config)
    end
end

return M
