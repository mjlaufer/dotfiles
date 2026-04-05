if IS_VSCODE then
    return
end

local util = require('mjlaufer.util')
local map = vim.keymap.set

-- Diagnostics
vim.diagnostic.config({
    underline = true,
    virtual_text = {
        spacing = 2,
        prefix = '',
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'if_many',
        header = '',
        prefix = '',
    },
})

-- Configure the current buffer when an LSP attaches to it.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('mjlaufer-lsp-attach', { clear = true }),
    callback = function(event)
        local buf = event.buf

        map('n', 'gd', vim.lsp.buf.definition, { buffer = buf, desc = 'Go to definition' })
        map('n', 'gD', vim.lsp.buf.declaration, { buffer = buf, desc = 'Go to declaration' })
        map('n', 'gI', vim.lsp.buf.implementation, { buffer = buf, desc = 'Go to implementations' })
        map('n', 'gr', vim.lsp.buf.references, { buffer = buf, desc = 'Go to references' })
        map('n', '<leader>aa', vim.lsp.buf.code_action, { buffer = buf, desc = 'Code actions' })
        map('x', '<leader>aa', vim.lsp.buf.code_action, { buffer = buf, desc = 'Code actions' })
        map(
            'n',
            '<leader>ac',
            vim.lsp.buf.incoming_calls,
            { buffer = buf, desc = 'List call sites' }
        )
        map('n', '<leader>ar', vim.lsp.buf.rename, { buffer = buf, desc = 'Rename references' })
        map(
            'n',
            '<leader>at',
            vim.lsp.buf.type_definition,
            { buffer = buf, desc = 'Go to type definition' }
        )
        map('n', '<leader>al', vim.lsp.codelens.run, { buffer = buf, desc = 'Run codelens action' })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable(false, { bufnr = buf })

            local toggle_inlay_hints = function()
                vim.lsp.inlay_hint.enable(
                    not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }),
                    { bufnr = buf }
                )
            end

            map(
                'n',
                '<leader>ah',
                toggle_inlay_hints,
                { buffer = buf, desc = 'Toggle inlay hints' }
            )
        end
    end,
})

-- Mason
require('mason').setup()
require('fidget').setup()

-- Lazydev
require('lazydev').setup({
    library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
})

-- Mason packages to install.
local ensure_installed = {
    'biome',
    'clangd',
    'css-lsp',
    'elm-language-server',
    'eslint-lsp',
    'golangci-lint-langserver',
    'gopls',
    'gradle-language-server',
    'html-lsp',
    'jdtls',
    'json-lsp',
    'lua-language-server',
    'rust-analyzer',
    'vtsls',
    'yaml-language-server',
}

util.install_mason_packages(ensure_installed)

-- Shared capabilities for all servers (cmp integration).
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities =
    vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
vim.lsp.config('*', { capabilities = capabilities })

-- Enable servers. Per-server overrides live in lsp/*.lua files.
-- jdtls is excluded because nvim-jdtls manages it via ftplugin/java.lua.
vim.lsp.enable({
    'biome',
    'clangd',
    'cssls',
    'elmls',
    'eslint',
    'golangci_lint_ls',
    'gopls',
    'gradle_ls',
    'html',
    'jsonls',
    'lua_ls',
    'rust_analyzer',
    'vtsls',
    'yamlls',
})
