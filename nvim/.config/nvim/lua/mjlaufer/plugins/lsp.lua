local util = require('mjlaufer.util')
local map = util.map

-- Diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { underline = true, virtual_text = { spacing = 2 } }
)
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-- Configure the current buffer when an LSP attaches to it.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('mjlaufer-lsp-attach', { clear = true }),
    callback = function(event)
        util.useWhichKey({ { '<leader>a', group = 'LSP' } })
        local opts = { buffer = event.buf, noremap = true, silent = true }

        map('n', 'gd', vim.lsp.buf.definition, 'Go to definition', opts)
        map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration', opts)
        map('n', 'gI', vim.lsp.buf.implementation, 'Go to implementations', opts)
        map('n', 'gr', vim.lsp.buf.references, 'Go to references', opts)
        map('n', '<leader>at', vim.lsp.buf.type_definition, 'Go to type definition', opts)
        map('n', '<leader>aa', vim.lsp.buf.code_action, 'Code actions', opts)
        map('n', '<leader>ac', vim.lsp.buf.incoming_calls, 'List call sites', opts)
        map('n', '<leader>ar', vim.lsp.buf.rename, 'Rename references', opts)

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Highlight references to the word under the cursor. See `:help CursorHold`.
        if
            client
            and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
        then
            local highlight_augroup =
                vim.api.nvim_create_augroup('mjlaufer-lsp-highlight', { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('mjlaufer-lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({
                        group = 'mjlaufer-lsp-highlight',
                        buffer = event2.buf,
                    })
                end,
            })
        end

        -- Enable inlay hints to be toggled.
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })

            local toggle_inlay_hints = function()
                vim.lsp.inlay_hint.enable(
                    not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
                    { bufnr = event.buf }
                )
            end

            map('n', '<leader>ah', toggle_inlay_hints, 'Toggle inlay hints', opts)
        end
    end,
})

-- LANGUAGE SERVERS
-- Add any server configuration overrides to the following tables.
local servers = {
    biome = {},
    clangd = {},
    cssls = {},
    elmls = {},
    eslint = {},
    golangci_lint_ls = {},
    gopls = {},
    gradle_ls = {
        cmd = { vim.fn.stdpath('data') .. '/mason/bin/gradle-language-server' },
        filetypes = { 'groovy', 'kotlin' },
        root_dir = require('lspconfig.util').root_pattern(
            'settings.gradle',
            'settings.gradle.kts',
            'build.gradle',
            'build.gradle.kts'
        ),
    },
    html = {},
    jdtls = {},
    jsonls = {
        settings = {
            json = {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
            },
        },
    },
    rust_analyzer = {},
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    -- Use Neovim's Lua compiler.
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Recognize `vim` and plenary.test_harness globals.
                    globals = { 'vim', 'describe', 'it', 'before_each' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files.
                    library = vim.api.nvim_get_runtime_file('', true),
                },
            },
        },
    },
    tsserver = {},
    yamlls = {
        settings = {
            yaml = {
                -- Disable built-in Schema Store support to use schemastore plugin.
                schemaStore = {
                    enable = false,
                    url = '',
                },
                schemas = require('schemastore').yaml.schemas(),
            },
        },
    },
}

-- By default, Neovim doesn't fully support the completion capabilities in the LSP specification.
-- The nvim-cmp plugin adds full support for LSP completion capabilities, so our LSP config must
-- create new capabilities with nvim-cmp, and broadcast them to the servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities =
    vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

-- Install and set up language servers.
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true,
    handlers = {
        function(server_name)
            -- For jdtls, use nvim-jdtls instead of nvim-lspconfig.
            if server_name == 'jdtls' then
                return
            end

            local server_opts = servers[server_name] or {}
            -- Apply server configuration overrides.
            server_opts.capabilities =
                vim.tbl_deep_extend('force', {}, capabilities, server_opts.capabilities or {})
            require('lspconfig')[server_name].setup(server_opts)
        end,
    },
})
