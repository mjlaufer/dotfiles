local util = require('mjlaufer.util')
local map = util.map

-- neodev must be set up before the LSP config.
local neodev = util.prequire('neodev')
if neodev then
    neodev.setup()
end

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
local fidget = util.prequire('fidget')
if fidget then
    fidget.setup()
end

local lspconfig = util.prequire('lspconfig')
local mason = util.prequire('mason');
local mason_lspconfig = util.prequire('mason-lspconfig')
if not lspconfig or not mason or not mason_lspconfig then
    return
end

mason.setup()
mason_lspconfig.setup({
    ensure_installed = {
        'cssls',
        'eslint',
        'golangci_lint_ls',
        'gopls',
        'gradle_ls',
        'html',
        'jdtls',
        'jsonls',
        'rust_analyzer',
        'sumneko_lua',
        'tsserver',
    },
    automatic_installation = true,
})

require('mjlaufer.lsp.null_ls')
local opts = require('mjlaufer.lsp.server_options')

lspconfig.cssls.setup(opts)
lspconfig.eslint.setup(opts)
lspconfig.golangci_lint_ls.setup(opts)
lspconfig.gopls.setup(opts)
lspconfig.gradle_ls.setup(require('mjlaufer.lsp.gradle_ls')(opts))
lspconfig.html.setup(opts)
lspconfig.jsonls.setup(require('mjlaufer.lsp.jsonls')(opts))
lspconfig.sumneko_lua.setup(require('mjlaufer.lsp.sumneko_lua')(opts))
lspconfig.tsserver.setup(require('mjlaufer.lsp.tsserver')(opts))

-- Rust
local rt = util.prequire('rust-tools')
if rt then
    local codelldb_path = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/'
    local adapter_path = codelldb_path .. 'adapter/codelldb'
    local liblldb_path = codelldb_path .. 'lldb/lib/liblldb.dylib'

    rt.setup({
        dap = {adapter = require('rust-tools.dap').get_codelldb_adapter(adapter_path, liblldb_path)},
        server = {
            on_attach = function(_, bufnr)
                -- Hover actions
                map('n', '<leader>rh', rt.hover_actions.hover_actions,
                    {buffer = bufnr, silent = true})
                -- Code action groups
                map('n', '<leader>ra', rt.code_action_group.code_action_group,
                    {buffer = bufnr, silent = true})
            end,
        },
    })
end
