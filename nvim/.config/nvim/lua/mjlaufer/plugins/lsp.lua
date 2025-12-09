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

        -- Enable inlay hints to be toggled.
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

-- LANGUAGE SERVERS

-- Mason packages to install (use Mason package names).
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

-- Server configurations (keyed by nvim-lspconfig package name).
local server_configs = {
    biome = {
        filetypes = {
            'astro',
            'css',
            'graphql',
            'html',
            'javascript',
            'javascriptreact',
            'json',
            'jsonc',
            'mjs',
            'mts',
            'svelte',
            'typescript',
            'typescript.tsx',
            'typescriptreact',
            'vue',
        },
    },
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
        root_markers = {
            'settings.gradle',
            'settings.gradle.kts',
            'build.gradle',
            'build.gradle.kts',
        },
    },
    jsonls = {
        settings = {
            json = {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
            },
        },
    },
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

-- Configure and enable language servers based on installed Mason packages.
local mason_registry = require('mason-registry')
for _, pkg in ipairs(mason_registry.get_installed_packages()) do
    local lsp_name = pkg.spec.neovim and pkg.spec.neovim.lspconfig
    if lsp_name then
        -- Skip jdtls because the nvim-jdtls plugin manages language server configuration.
        if lsp_name == 'jdtls' then
            goto continue
        end

        local config = server_configs[lsp_name] or {}
        config.capabilities =
            vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})

        vim.lsp.config(lsp_name, config)
        vim.lsp.enable(lsp_name)

        ::continue::
    end
end
