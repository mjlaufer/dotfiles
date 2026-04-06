if IS_VSCODE then
    return
end

require('nvim-autopairs').setup({
    check_ts = true,
    ts_config = {
        lua = { 'string', 'source' },
        javascript = { 'string', 'template_string' },
    },
})
