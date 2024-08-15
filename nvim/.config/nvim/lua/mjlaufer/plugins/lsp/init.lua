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

-- Set whichkey LSP entry.
util.useWhichKey({ ['<leader>a'] = { name = 'LSP' } })

map('n', '<leader>ad', vim.diagnostic.open_float, 'Show diagnostics')
map('n', '<leader>ld', vim.diagnostic.setloclist, 'Show diagnostics in location list')
map('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')

-- Install and set up language servers.
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',
        'cssls',
        'elmls',
        'eslint',
        'golangci_lint_ls',
        'gopls',
        'gradle_ls',
        'html',
        'jdtls',
        'jsonls',
        'rust_analyzer',
        'lua_ls',
        'tsserver',
    },
    automatic_installation = true,
})

local lspconfig = require('lspconfig')
local opts = require('mjlaufer.plugins.lsp.server_options')

lspconfig.clangd.setup(opts)
lspconfig.cssls.setup(opts)
lspconfig.elmls.setup(opts)
lspconfig.eslint.setup(opts)
lspconfig.golangci_lint_ls.setup(opts)
lspconfig.gopls.setup(opts)
lspconfig.gradle_ls.setup(require('mjlaufer.plugins.lsp.gradle_ls')(opts))
lspconfig.html.setup(opts)
lspconfig.jsonls.setup(require('mjlaufer.plugins.lsp.jsonls')(opts))
lspconfig.lua_ls.setup(require('mjlaufer.plugins.lsp.lua_ls')(opts))

-- TypeScript
require('typescript').setup({
    server = {
        on_attach = function(client, bufnr)
            opts.on_attach(client, bufnr)

            util.useWhichKey({ ['<leader>at'] = { name = 'TS Utils' } })

            local map_opts = { buffer = bufnr, noremap = true, silent = true }
            map('n', '<leader>atf', ':TypescriptFixAll<CR>', 'Fix all', map_opts)
            map(
                'n',
                '<leader>ati',
                ':TypescriptAddMissingImports<CR>',
                'Add missing imports',
                map_opts
            )
            map('n', '<leader>ato', ':TypescriptOrganizeImports<CR>', 'Organize imports', map_opts)
            map('n', '<leader>atr', ':TypescriptRenameFile<CR>', 'Rename file', map_opts)
            map(
                'n',
                '<leader>atd',
                ':TypescriptGoToSourceDefinition<CR>',
                'Go to source definition',
                map_opts
            )
        end,
        capabilities = opts.capabilities,
        settings = {
            javascript = {
                inlayHints = {
                    includeInlayEnumMemberValueHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                },
            },
            typescript = {
                inlayHints = {
                    includeInlayEnumMemberValueHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                },
            },
        },
    },
})

-- Rust
local rt = require('rust-tools')
local codelldb_path = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/'
local adapter_path = codelldb_path .. 'adapter/codelldb'
local liblldb_path = codelldb_path .. 'lldb/lib/liblldb.dylib'

rt.setup({
    tools = { inlay_hints = { highlight = 'LineNr' } },
    dap = { adapter = require('rust-tools.dap').get_codelldb_adapter(adapter_path, liblldb_path) },
    server = {
        on_attach = function(client, bufnr)
            opts.on_attach(client, bufnr)

            util.useWhichKey({ ['<leader>r'] = { name = 'Rust Tools' } })
            -- Hover actions
            map(
                'n',
                '<leader>rh',
                rt.hover_actions.hover_actions,
                { buffer = bufnr, silent = true }
            )
            -- Code action groups
            map(
                'n',
                '<leader>ra',
                rt.code_action_group.code_action_group,
                { buffer = bufnr, silent = true }
            )
        end,
    },
})
