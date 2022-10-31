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
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end

    -- LSP Saga
    local saga = util.prequire('lspsaga')
    if saga then
        map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', 'Hover', opts)
        map('n', '<leader>lp', '<cmd>Lspsaga preview_definition<CR>', 'Preview definition', opts)
        map('n', '<leader>lr', '<cmd>Lspsaga rename<CR>', 'Rename all references', opts);
        map('n', '<leader>ls', '<cmd>Lspsaga signature_help<CR>', 'Signature help', opts)
        map('n', '<leader>la', require('lspsaga.codeaction').code_action, 'Code actions', opts)
    end
end

-- Set up completion using nvim-cmp with Neovim's built-in LSP client.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
M.capabilities = capabilities

return M
