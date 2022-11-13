local util = require('mjlaufer.util')
local bmap = util.bmap

local ts_utils = util.prequire('nvim-lsp-ts-utils')
if not ts_utils then
    return function(opts)
        return opts
    end
end

return function(opts)
    return {
        -- Needed for inlayHints
        init_options = require('nvim-lsp-ts-utils').init_options,
        on_attach = function(client, bufnr)
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

            util.useWhichKey({['<leader>lt'] = {name = 'TS Utils'}})

            bmap(bufnr, 'n', '<leader>lto', ':TSLspOrganize<CR>', 'Organize imports')
            bmap(bufnr, 'n', '<leader>ltr', ':TSLspRenameFile<CR>', 'Rename file')
            bmap(bufnr, 'n', '<leader>lti', ':TSLspImportAll<CR>', 'Import all')
            bmap(bufnr, 'n', '<leader>lth', ':TSLspToggleInlayHints<CR>', 'Toggle inlay hints')

        end,
        capabilities = opts.capabilities,
    }
end
