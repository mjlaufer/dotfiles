local util = require('mjlaufer.util')

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

-- Diagnostic icons
vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
        {underline = true, virtual_text = {spacing = 2}})
vim.fn.sign_define('DiagnosticSignError', {text = '', texthl = 'DiagnosticSignError'})
vim.fn.sign_define('DiagnosticSignWarn', {text = '', texthl = 'DiagnosticSignWarn'})
vim.fn
    .sign_define('DiagnosticSignInformation', {text = '', texthl = 'DiagnosticSignInformation'})
vim.fn.sign_define('DiagnosticSignHint', {text = '', texthl = 'DiagnosticSignHint'})

local opts = {noremap = true, silent = true}
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, opts)

util.useWhichKey({
    ['<leader>l'] = {
        name = 'LSP',
        d = 'Show diagnostics',
        ['[d'] = 'Previous diagnostic',
        [']d'] = 'Next diagnostic',
        q = 'Add diagnostics to location list',
    },
})
