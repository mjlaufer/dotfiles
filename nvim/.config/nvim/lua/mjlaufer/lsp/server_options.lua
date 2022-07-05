local util = require('mjlaufer.util')

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local M = {}

M.on_attach = function(client, bufnr)
    -- Enable completion triggered by <C-x><C-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.*` for documentation on any of the below functions
    local opts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>ll', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, opts)

    util.useWhichKey({
        gD = 'Go to declaration',
        gd = 'Go to definition',
        K = 'Hover',
        ['<leader>l'] = {
            name = 'LSP',
            t = 'Go to type definition',
            i = 'Show implementations',
            s = 'Signature help',
            l = 'List references',
            r = 'Rename all references',
            c = 'Code actions',
        },
    })

    -- Format on save (using null-ls built-in formatters)
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                vim.lsp.buf.formatting_seq_sync()
            end,
        })
    end
end

-- Set up completion using nvim-cmp with Neovim's built-in LSP client.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
M.capabilities = capabilities

return M
