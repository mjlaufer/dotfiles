local util = require('mjlaufer.util')
local map = util.map

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local M = {}

M.on_attach = function(client, bufnr)
    -- Enable completion triggered by <C-x><C-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    util.useWhichKey({['<leader>l'] = {name = 'LSP'}})
    -- See `:help vim.*` for documentation on any of the below functions
    local opts = {noremap = true, silent = true, buffer = bufnr}
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration', opts)
    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition', opts)
    map('n', 'gt', vim.lsp.buf.type_definition, 'Go to type definition', opts)
    map('n', 'K', vim.lsp.buf.hover, 'Hover', opts)
    map('n', '<leader>ll', vim.lsp.buf.references, 'List references', opts)
    map('n', '<leader>lr', vim.lsp.buf.rename, 'Rename all references', opts)
    map('n', '<leader>li', vim.lsp.buf.implementation, 'List implementations', opts)
    map('n', '<leader>lc', vim.lsp.buf.incoming_calls, 'List call sites', opts)
    map('n', '<leader>ls', vim.lsp.buf.signature_help, 'Signature help', opts)
    map('n', '<leader>la', vim.lsp.buf.code_action, 'Code actions', opts)

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

    -- LSP Saga
    local saga = util.prequire('lspsaga')
    if saga then
        local action = require('lspsaga.action')
        map('n', '<C-f>', function()
            action.smart_scroll_with_saga(1)
        end, nil, opts)
        map('n', '<C-b>', function()
            action.smart_scroll_with_saga(-1)
        end, nil, opts)

        map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', 'Hover', opts)
        map('n', '<leader>lp', '<cmd>Lspsaga preview_definition<CR>', 'Preview definition', opts)
        map('n', '<leader>lr', '<cmd>Lspsaga rename<CR>', 'Rename all references', opts);
        map('n', '<leader>ls', '<cmd>Lspsaga signature_help<CR>', 'Signature help', opts)

        local code_action = require('lspsaga.codeaction')
        map('n', '<leader>la', code_action.code_action, 'Code actions', opts)
    end
end

-- Set up completion using nvim-cmp with Neovim's built-in LSP client.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
M.capabilities = capabilities

return M
