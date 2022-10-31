local opts = require('mjlaufer.lsp.server_options')

return {
    settings = {
        Lua = {
            runtime = {
                -- Use Neovim's Lua compiler.
                version = 'LuaJIT',
                -- Set up lua path.
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Recognize `vim` and plenary.test_harness globals.
                globals = {'vim', 'describe', 'it', 'before_each'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files.
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
    on_attach = function(client, bufnr)
        -- Prevent sumneko_lua from formatting; use null-ls + LuaFormatter instead.
        client.server_capabilities.documentFormattingProvider = false
        opts.on_attach(client, bufnr)
    end,
    capabilities = opts.capabilities,
}
