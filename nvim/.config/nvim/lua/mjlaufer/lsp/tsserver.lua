local opts = require('mjlaufer/lsp/server-options')

local status_ok, ts_utils = pcall(require, 'nvim-lsp-ts-utils')
if not status_ok then
    return {
        on_attach = function(client, bufnr)
            -- Prevent tsserver from formatting; use efm instead
            client.resolved_capabilities.document_formatting = false
            opts.on_attach(client, bufnr)
        end,
        capabilities = opts.capabilities,
    }
end

return {
    -- Needed for inlayHints
    init_options = require('nvim-lsp-ts-utils').init_options,
    on_attach = function(client, bufnr)
        -- Prevent tsserver from formatting; use efm instead
        client.resolved_capabilities.document_formatting = false

        opts.on_attach(client, bufnr)

        -- defaults
        ts_utils.setup({
            debug = false,
            disable_commands = false,
            enable_import_on_completion = false,

            -- import all
            import_all_timeout = 5000, -- ms

            -- lower numbers = higher priority
            import_all_priorities = {
                same_file = 1, -- add to existing import statement
                local_files = 2, -- git files or files with relative path markers
                buffer_content = 3, -- loaded buffer content
                buffers = 4, -- loaded buffer names
            },
            import_all_scan_buffers = 100,
            import_all_select_source = false,

            -- filter diagnostics
            filter_out_diagnostics_by_severity = {},
            filter_out_diagnostics_by_code = {},

            -- inlay hints
            auto_inlay_hints = false,
            inlay_hints_highlight = 'Comment',

            -- update imports on file move
            update_imports_on_move = true,
            require_confirmation_on_move = true,
            watch_dir = nil,
        })

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)

        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        local map_opts = {noremap = true, silent = true}
        buf_set_keymap('n', '<leader>lto', ':TSLspOrganize<CR>', map_opts)
        buf_set_keymap('n', '<leader>ltr', ':TSLspRenameFile<CR>', map_opts)
        buf_set_keymap('n', '<leader>lti', ':TSLspImportAll<CR>', map_opts)
        buf_set_keymap('n', '<leader>lth', ':TSLspToggleInlayHints<CR>', map_opts)

        require('which-key').register({
            ['<leader>lt'] = {
                name = 'TS Utils',
                o = 'Organize imports',
                r = 'Rename file',
                i = 'Import all',
                h = 'Toggle inlay hints',
            },
        })
    end,
    capabilities = opts.capabilities,
}
