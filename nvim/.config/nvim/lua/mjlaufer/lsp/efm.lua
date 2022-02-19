local opts = require('mjlaufer/lsp/server_options')

local prettier = {
    formatCommand = './node_modules/.bin/prettier --stdin-filepath ${INPUT}',
    formatStdin = true,
}

return {
    init_options = {documentFormatting = true},
    root_dir = function(fname)
        return require('lspconfig/util').root_pattern('.git')(fname) or vim.fn.getcwd()
    end,
    settings = {
        rootMarkers = {'.prettierrc.json', '.prettierrc.js', 'prettier.config.js', '.git/'},
        languages = {
            javascript = {prettier},
            javascriptreact = {prettier},
            ['javascriptreact.jsx'] = {prettier},
            typescript = {prettier},
            typescriptreact = {prettier},
            ['typescriptreact.tsx'] = {prettier},
            json = {prettier},
            html = {prettier},
            css = {prettier},
            scss = {prettier},
            markdown = {prettier},
            yaml = {prettier},
            lua = {{formatCommand = 'lua-format -i', formatStdin = true}},
        },
    },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
        'json',
        'html',
        'css',
        'scss',
        'lua',
        'markdown',
        'yaml',
    },
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
}
