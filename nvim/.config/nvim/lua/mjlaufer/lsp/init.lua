local util = require('mjlaufer.util')

local nvim_lsp = util.prequire('lspconfig')
local lsp_installer = util.prequire('nvim-lsp-installer')
if not nvim_lsp or not lsp_installer then
    return
end

local server_opts = {
    eslint = require('mjlaufer.lsp.eslint'),
    golangci_lint_ls = require('mjlaufer.lsp.golangci_lint_ls'),
    gopls = require('mjlaufer.lsp.gopls'),
    jsonls = require('mjlaufer.lsp.jsonls'),
    sumneko_lua = require('mjlaufer.lsp.sumneko_lua'),
    tsserver = require('mjlaufer.lsp.tsserver'),
}
local servers = {'eslint', 'golangci_lint_ls', 'gopls', 'jsonls', 'sumneko_lua', 'tsserver'}

for _, server in ipairs(servers) do
    local server_available, requested_server = lsp_installer.get_server(server)

    if server_available then
        local opts = server_opts[requested_server.name] or {}
        requested_server:setup(opts)
    end

    if not requested_server:is_installed() then
        requested_server:install()
    end
end

-- Set up efm separately (efm is installed with Homebrew)
local efm_opts = require('mjlaufer.lsp.efm')
nvim_lsp.efm.setup(efm_opts)

-- Diagnostic icons
vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
        {underline = true, virtual_text = {spacing = 2}})
vim.fn.sign_define('DiagnosticSignError', {text = '', texthl = 'DiagnosticSignError'})
vim.fn.sign_define('DiagnosticSignWarn', {text = '', texthl = 'DiagnosticSignWarn'})
vim.fn
    .sign_define('DiagnosticSignInformation', {text = '', texthl = 'DiagnosticSignInformation'})
vim.fn.sign_define('DiagnosticSignHint', {text = '', texthl = 'DiagnosticSignHint'})
