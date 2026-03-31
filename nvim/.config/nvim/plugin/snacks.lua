if IS_VSCODE then
    return
end

require('snacks').setup({
    bigfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    scroll = { enabled = true },
})
