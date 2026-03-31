if IS_VSCODE then
    return
end

require('colorizer').setup({ filetypes = { '*', css = { rgb_fn = true, hsl_fn = true } } })
