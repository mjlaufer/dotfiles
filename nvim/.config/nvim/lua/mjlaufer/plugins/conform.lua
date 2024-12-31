require('conform').setup({
    formatters = {
        biome = {
            command = function()
                -- Resolve Biome from `node_modules`.
                return vim.fn.findfile('node_modules/.bin/biome', vim.fn.expand('%:p:h') .. ';')
            end,
            stdin = true,
        },
    },
    formatters_by_ft = {
        c = { 'clang_format' },
        css = { 'biome', 'prettier', stop_after_first = true },
        go = { 'goimports' },
        html = { 'prettier' },
        java = { 'google-java-format' },
        javascript = { 'biome', 'prettier', stop_after_first = true },
        javascriptreact = { 'biome', 'prettier', stop_after_first = true },
        json = { 'biome', 'prettier', stop_after_first = true },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        rust = { 'rustfmt' },
        typescript = { 'biome', 'prettier', stop_after_first = true },
        typescriptreact = { 'biome', 'prettier', stop_after_first = true },
    },
    format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 2000,
    },
})

local util = require('conform.util')
util.add_formatter_args(require('conform.formatters.google-java-format'), { '--aosp' })
