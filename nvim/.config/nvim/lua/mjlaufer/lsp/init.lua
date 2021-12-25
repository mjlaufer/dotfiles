local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    buf_set_keymap('n', '<leader>wa',
                   '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr',
                   '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl',
                   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                   opts)
    buf_set_keymap('n', '<leader>D',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
                   opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- Diagnostics
    buf_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>',
                   opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>',
                   opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>',
                   opts)

    -- Prevent tsserver from formatting; use efm instead
    if client.name == 'tsserver' then
        client.resolved_capabilities.document_formatting = false
    end

    -- Format on save (using efm)
    if client.resolved_capabilities.document_formatting then
        vim.cmd [[
            augroup Format
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
            augroup END
        ]]
    end
end

-- Set up completion using nvim-cmp with Neovim's built-in LSP client.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- LSP Installer
local lsp_installer = require('nvim-lsp-installer')
local server_opts = {
    eslint = require('mjlaufer.lsp.eslint'),
    jsonls = require('mjlaufer.lsp.jsonls'),
    sumneko_lua = require('mjlaufer.lsp.sumneko-lua'),
    tsserver = {}
}
local servers = {'eslint', 'jsonls', 'sumneko_lua', 'tsserver'}

for _, server in ipairs(servers) do
    local server_available, requested_server = lsp_installer.get_server(server)

    if server_available then
        local opts = server_opts[requested_server.name] or {}
        opts.on_attach = on_attach
        opts.capabilities = capabilities
        requested_server:setup(opts)
    end

    if not requested_server:is_installed() then requested_server:install() end
end

-- Set up efm separately (efm is installed with Homebrew)
local efm_opts = require('mjlaufer.lsp.efm')
efm_opts.on_attach = on_attach
efm_opts.capabilities = capabilities
nvim_lsp.efm.setup(efm_opts)

-- Diagnostic icons
vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {underline = true, virtual_text = {spacing = 2}})
vim.fn.sign_define('DiagnosticSignError', {text = '', texthl = 'GruvboxRed'})
vim.fn.sign_define('DiagnosticSignWarn',
                   {text = '', texthl = 'GruvboxYellow'})
vim.fn.sign_define('DiagnosticSignInformation',
                   {text = '', texthl = 'GruvboxBlue'})
vim.fn.sign_define('DiagnosticSignHint', {text = '', texthl = 'GruvboxAqua'})
