P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function(...)
    return require('plenary.reload').reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end

RELOAD_CONFIG = function()
    for name, _ in pairs(package.loaded) do
        if name:match('^mjlaufer') then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
end
