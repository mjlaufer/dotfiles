local wk = not IS_VSCODE and require('which-key') or nil

local M = {}

M.map = function(mode, lhs, rhs, desc, opts)
    local has_desc = type(desc) == 'string'
    -- Get options.
    if not has_desc and opts == nil then
        opts = desc
    end
    opts = opts or { noremap = true, silent = true }

    vim.keymap.set(mode, lhs, rhs, opts)

    -- Set whichkey.
    if has_desc and wk and mode == 'n' then
        wk.add({ mode = { 'n' }, { lhs, rhs, desc = desc } })
    end
end

M.useWhichKey = function(config)
    if not wk then
        return
    else
        wk.add(config)
    end
end

-- Uses Mason to install the provided packages.
M.install_mason_packages = function(mason_package_names)
    local mason_registry = require('mason-registry')

    local function ensure_installed()
        for _, name in pairs(mason_package_names) do
            if mason_registry.has_package(name) then
                local package = mason_registry.get_package(name)
                if not package:is_installed() then
                    vim.notify(
                        'Installing ' .. name .. '...',
                        vim.log.levels.INFO,
                        { title = 'Mason' }
                    )
                    package:install():once(
                        'closed',
                        vim.schedule_wrap(function()
                            vim.notify(
                                'Successfully installed: ' .. name,
                                vim.log.levels.INFO,
                                { title = 'Mason' }
                            )
                        end)
                    )
                end
            end
        end
    end

    mason_registry.refresh(vim.schedule_wrap(ensure_installed))
end

return M
