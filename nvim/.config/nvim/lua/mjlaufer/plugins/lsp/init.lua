local util = require('mjlaufer.util')
local map = util.map

-- Diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
        {underline = true, virtual_text = {spacing = 2}})
vim.fn.sign_define('DiagnosticSignError', {text = '', texthl = 'DiagnosticSignError'})
vim.fn.sign_define('DiagnosticSignWarn', {text = '', texthl = 'DiagnosticSignWarn'})
vim.fn
    .sign_define('DiagnosticSignInformation', {text = '', texthl = 'DiagnosticSignInformation'})
vim.fn.sign_define('DiagnosticSignHint', {text = '', texthl = 'DiagnosticSignHint'})

-- Set whichkey LSP entry.
util.useWhichKey({['<leader>a'] = {name = 'LSP'}})

map('n', '<leader>ad', vim.diagnostic.open_float, 'Show diagnostics')
map('n', '<leader>ld', vim.diagnostic.setloclist, 'Show diagnostics in location list')
map('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')

-- Install and set up language servers.
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'cssls',
        'eslint',
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
require('mjlaufer.plugins.lsp.null_ls')

lspconfig.cssls.setup(opts)
lspconfig.eslint.setup(opts)
lspconfig.gradle_ls.setup(require('mjlaufer.plugins.lsp.gradle_ls')(opts))
lspconfig.html.setup(opts)
lspconfig.jsonls.setup(require('mjlaufer.plugins.lsp.jsonls')(opts))
lspconfig.lua_ls.setup(require('mjlaufer.plugins.lsp.lua_ls')(opts))
lspconfig.tsserver.setup(require('mjlaufer.plugins.lsp.tsserver')(opts))

-- Rust
local rt = require('rust-tools')
local codelldb_path = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/'
local adapter_path = codelldb_path .. 'adapter/codelldb'
local liblldb_path = codelldb_path .. 'lldb/lib/liblldb.dylib'

rt.setup({
    tools = {inlay_hints = {highlight = 'LineNr'}},
    dap = {adapter = require('rust-tools.dap').get_codelldb_adapter(adapter_path, liblldb_path)},
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            map('n', '<leader>rh', rt.hover_actions.hover_actions, {buffer = bufnr, silent = true})
            -- Code action groups
            map('n', '<leader>ra', rt.code_action_group.code_action_group,
                {buffer = bufnr, silent = true})
        end,
    },
})
