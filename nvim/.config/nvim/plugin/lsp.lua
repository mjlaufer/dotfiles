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

        -- By default `gd` does a text-based local declaration search, so this map is ergonomic in the LSP context.
        map('n', 'gd', vim.lsp.buf.definition, { buffer = buf, desc = 'Go to definition' })
        map('n', 'grc', vim.lsp.buf.incoming_calls, { buffer = buf, desc = 'List call sites' })

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Highlight references of the word under cursor.
        if
            client
            and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
        then
            local highlight_group =
                vim.api.nvim_create_augroup('mjlaufer-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = buf,
                group = highlight_group,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
                buffer = buf,
                group = highlight_group,
                callback = vim.lsp.buf.clear_references,
            })
        end

        -- Inlay hints
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable(false, { bufnr = buf })

            local toggle_inlay_hints = function()
                vim.lsp.inlay_hint.enable(
                    not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }),
                    { bufnr = buf }
                )
            end

            map('n', 'grh', toggle_inlay_hints, { buffer = buf, desc = 'Toggle inlay hints' })
        end
    end,
})

-- Enable native LSP completion on attach.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('mjlaufer-lsp-completion', { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
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
