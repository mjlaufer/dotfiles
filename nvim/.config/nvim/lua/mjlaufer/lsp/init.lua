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

    -- See `:help vim.*` for documentation on any of the below functions
    buf_set_keymap('n', '<leader>lgD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<leader>lgd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>lgt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>lu', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>lc', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    require('which-key').register({
        ['<leader>l'] = {
            name = 'LSP',
            g = {
                name = 'Go to',
                D = 'Go to declaration',
                d = 'Go to definition',
                t = 'Go to type definition',
            },
            u = 'Hover',
            i = 'Show implementations',
            s = 'Signature help',
            l = 'List references',
            r = 'Rename all references',
            c = 'Code actions',
            d = 'Show diagnostics',
            ['[d'] = 'Previous diagnostic',
            [']d'] = 'Next diagnostic',
            q = 'Add diagnostics to location list',
        },
    })

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
    tsserver = {},
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

    if not requested_server:is_installed() then
        requested_server:install()
    end
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
vim.fn.sign_define('DiagnosticSignError', {text = '', texthl = 'DiagnosticSignError'})
vim.fn.sign_define('DiagnosticSignWarn', {text = '', texthl = 'DiagnosticSignWarn'})
vim.fn
    .sign_define('DiagnosticSignInformation', {text = '', texthl = 'DiagnosticSignInformation'})
vim.fn.sign_define('DiagnosticSignHint', {text = '', texthl = 'DiagnosticSignHint'})
