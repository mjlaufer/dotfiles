return function(opts)
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
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
    }
end
