local util = require('mjlaufer.util')
local map = util.map

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
    update_in_insert = false, -- Only update diagnostics when switching to normal mode.
    severity_sort = true, -- Show errors before warnings.
    float = {
        border = 'rounded',
        source = 'if_many', -- Show source if multiple LSPs provide diagnostics.
        header = '',
        prefix = '',
    },
})

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
        map('n', '<leader>aa', vim.lsp.buf.code_action, 'Code actions', opts)
        map('x', '<leader>aa', vim.lsp.buf.code_action, 'Code actions', opts)
        map('n', '<leader>ac', vim.lsp.buf.incoming_calls, 'List call sites', opts)
        map('n', '<leader>ar', vim.lsp.buf.rename, 'Rename references', opts)
        map('n', '<leader>at', vim.lsp.buf.type_definition, 'Go to type definition', opts)
        map('n', '<leader>al', vim.lsp.codelens.run, 'Run codelens action', opts)

        -- Enable inlay hints to be toggled.
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
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

local vtslsLangSettings = {
    inlayHints = {
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
    },
}

-- Add any server configuration overrides to the following tables.
local servers = {
    biome = {},
    clangd = {},
    cssls = {},
    elmls = {},
    eslint = {},
    golangci_lint_ls = {},
    gopls = {
        settings = {
            gopls = {
                codelenses = {
                    gc_details = false,
                    generate = true,
                    regenerate_cgo = true,
                    run_govulncheck = true,
                    test = true,
                    tidy = true,
                    upgrade_dependency = true,
                    vendor = true,
                },
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
                analyses = {
                    nilness = true,
                    unusedparams = true,
                    unusedwrite = true,
                    useany = true,
                },
                completeUnimported = true,
                usePlaceholders = true,
                staticcheck = true,
                directoryFilters = { '-.git', '-.idea', '-.vscode', '-.node_modules' },
                gofumpt = true,
            },
        },
    },
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
    lua_ls = {},
    vtsls = {
        settings = {
            vtsls = {
                -- Automatically use workspace version of TypeScript lib on startup.
                autoUseWorkspaceTsdk = true,
            },
            javascript = vtslsLangSettings,
            typescript = vtslsLangSettings,
        },
    },
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

-- Configure language servers.
for server_name, server_config in pairs(servers) do
    -- Skip jdtls because the nvim-jdtls plugin manages language server configuration.
    if server_name == 'jdtls' then
        goto continue
    end

    local config = vim.tbl_deep_extend('force', {}, server_config)
    config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})

    vim.lsp.config(server_name, config)
    vim.lsp.enable(server_name)

    ::continue::
end
