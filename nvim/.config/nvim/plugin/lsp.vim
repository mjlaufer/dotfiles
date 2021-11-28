lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    -- Format on save (using efm)
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
        vim.api.nvim_command [[augroup END]]
    end
end

-- Set up completion using nvim-cmp with Neovim's built-in LSP client.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

nvim_lsp.tsserver.setup {
    on_attach = function(client)
        -- Disable tsserver formatting; use efm.
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end,
    capabilities = capabilities
}

-- efm eslint config
local eslint = {
    lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {
        "%f(%l,%c): %tarning %m",
        "%f(%l,%c): %rror %m",
    },
    lintSource = "eslint",
}

-- efm prettier config
local prettier = {
    formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
    formatStdin = true,
}

-- Call in efm.setup to determine whether to run eslint_d.
local has_eslintrc = function() 
    local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

    if not vim.tbl_isempty(eslintrc) then
        return true
    end

    if vim.fn.filereadable("package.json") then
        if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
            return true
        end
    end

    return false
end

nvim_lsp.efm.setup {
    on_attach = on_attach,
    capabilities = capabilities, 
    init_options = { documentFormatting = true },
    root_dir = function(_)
        if not has_eslintrc() then
            return nil
        end
        return vim.fn.getcwd()
    end,
    settings = {
        rootMarkers = { ".eslintrc.json", ".git/" },
        languages = {
            lua = {
                { formatCommand = "lua-format -i", formatStdin = true }
            },
            javascript = { prettier, eslint },
            javascriptreact = { prettier, eslint },
            ["javascriptreact.jsx"] = { prettier, eslint },
            typescript = { prettier, eslint },
            typescriptreact = { prettier, eslint },
            ["typescriptreact.tsx"] = { prettier, eslint },
            yaml = { prettier },
            json = { prettier },
            html = { prettier },
            scss = { prettier },
            css = { prettier },
            markdown = { prettier }
        }
    },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx"
    }
}

-- Diagnostic icons
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {
            spacing = 4,
            prefix = ' '
        }
    }
)

local saga = require 'lspsaga'
saga.init_lsp_saga {
    code_action_prompt = {
        enable = false
    },
}
EOF

" LSP provider to find the cursor word definition and references
nnoremap <silent> gf <Cmd>Lspsaga lsp_finder<CR>
" Preview definition
nnoremap <silent> gp :Lspsaga preview_definition<CR>
