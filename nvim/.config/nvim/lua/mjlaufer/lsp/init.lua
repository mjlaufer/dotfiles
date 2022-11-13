local util = require('mjlaufer.util')
local map = util.map
local bmap = util.bmap

-- Diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
        {underline = true, virtual_text = {spacing = 2}})
vim.fn.sign_define('DiagnosticSignError', {text = '', texthl = 'DiagnosticSignError'})
vim.fn.sign_define('DiagnosticSignWarn', {text = '', texthl = 'DiagnosticSignWarn'})
vim.fn
    .sign_define('DiagnosticSignInformation', {text = '', texthl = 'DiagnosticSignInformation'})
vim.fn.sign_define('DiagnosticSignHint', {text = '', texthl = 'DiagnosticSignHint'})

util.useWhichKey({['<leader>l'] = {name = 'LSP'}})

map('n', '<leader>ld', vim.diagnostic.open_float, 'Show diagnostics')
map('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')
map('n', '<leader>lq', vim.diagnostic.setloclist, 'Add diagnostics to location list')

-- Initialize LSP Saga before setting up language servers.
local saga = util.prequire('lspsaga')
if saga then
    saga.init_lsp_saga({max_preview_lines = 32})
    map('n', '<leader>ld', '<cmd>Lspsaga show_line_diagnostics<CR>', 'Show diagnostics')
    map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Previous diagnostic')
    map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next diagnostic')
end

-- Install and set up language servers.
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
        'html',
        'jsonls',
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
lspconfig.html.setup(opts)
lspconfig.jsonls.setup(require('mjlaufer.lsp.jsonls')(opts))
lspconfig.sumneko_lua.setup(require('mjlaufer.lsp.sumneko_lua')(opts))
lspconfig.tsserver.setup(require('mjlaufer.lsp.tsserver')(opts))

-- Aerial (symbol outline)
local aerial = util.prequire('aerial')
if aerial then
    util.useWhichKey({['<leader>a'] = {name = 'Aerial'}})

    aerial.setup({
        on_attach = function(bufnr)
            bmap(bufnr, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', 'Aerial')
        end,
    })
end
