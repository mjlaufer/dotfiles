local util = require('mjlaufer.util')
local map = util.map

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local M = {}

-- This function runs when an LSP connects to a particular buffer.
M.on_attach = function(client, bufnr)
    -- Enable completion triggered by <C-x><C-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.*` for documentation on any of the below functions
    local opts = {buffer = bufnr, noremap = true, silent = true}
    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition', opts)
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration', opts)
    map('n', 'gt', vim.lsp.buf.type_definition, 'Go to type definition', opts)
    map('n', 'K', vim.lsp.buf.hover, 'Hover documentation', opts) -- See `:help K`
    map('n', '<leader>as', vim.lsp.buf.signature_help, 'Signature documentation', opts)
    map('n', '<leader>al', vim.lsp.buf.references, 'List references', opts)
    map('n', '<leader>ar', vim.lsp.buf.rename, 'Rename all references', opts)
    map('n', '<leader>ai', vim.lsp.buf.implementation, 'List implementations', opts)
    map('n', '<leader>ac', vim.lsp.buf.incoming_calls, 'List call sites', opts)
    map('n', '<leader>aa', vim.lsp.buf.code_action, 'Code actions', opts)

    -- Format buffer with LSP.
    local fmt = function()
        vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(_client)
                -- Use null-ls instead of the clients excluded below.
                return not (_client.name == 'cssls' or _client.name == 'jdtls' or _client.name ==
                           'html' or _client.name == 'sumneko_lua' or _client.name == 'tsserver')
            end,
        })
    end

    -- Format on save.
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
        vim.api
            .nvim_create_autocmd('BufWritePre', {group = augroup, buffer = bufnr, callback = fmt})
    end

    -- Create a `:Format` command local to the LSP buffer.
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        fmt()
    end, {desc = 'Format current buffer with LSP'})
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

return M
