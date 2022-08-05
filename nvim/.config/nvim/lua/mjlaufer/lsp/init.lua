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
    saga.init_lsp_saga()
    map('n', '<leader>ld', '<cmd>Lspsaga show_line_diagnostics<CR>', 'Show diagnostics')
    map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Previous diagnostic')
    map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next diagnostic')
end

-- Install and set up language servers.
local lspconfig = util.prequire('lspconfig')
local lsp_installer = util.prequire('nvim-lsp-installer')
if not lspconfig or not lsp_installer then
    return
end

lsp_installer.setup({
    ensure_installed = {'eslint', 'golangci_lint_ls', 'gopls', 'jsonls', 'sumneko_lua', 'tsserver'},
    automatic_installation = true,
})

require('mjlaufer.lsp.null_ls')
lspconfig.eslint.setup(require('mjlaufer.lsp.eslint'))
lspconfig.golangci_lint_ls.setup(require('mjlaufer.lsp.golangci_lint_ls'))
lspconfig.gopls.setup(require('mjlaufer.lsp.gopls'))
lspconfig.jsonls.setup(require('mjlaufer.lsp.jsonls'))
lspconfig.sumneko_lua.setup(require('mjlaufer.lsp.sumneko_lua'))
lspconfig.tsserver.setup(require('mjlaufer.lsp.tsserver'))

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
