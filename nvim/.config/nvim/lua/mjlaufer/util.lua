local M = {}

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
                            if package:is_installed() then
                                vim.notify(
                                    'Successfully installed: ' .. name,
                                    vim.log.levels.INFO,
                                    { title = 'Mason' }
                                )
                            else
                                vim.notify(
                                    'Failed to install: ' .. name,
                                    vim.log.levels.ERROR,
                                    { title = 'Mason' }
                                )
                            end
                        end)
                    )
                end
            end
        end
    end

    mason_registry.refresh(vim.schedule_wrap(ensure_installed))
end

return M
