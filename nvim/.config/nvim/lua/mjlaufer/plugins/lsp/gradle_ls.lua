local util = require('lspconfig/util')

return function(opts)
    local gradle_ls_path = vim.fn.stdpath('data') .. '/mason/bin/gradle-language-server'
    return {
        cmd = { gradle_ls_path },
        filetypes = { 'groovy', 'kotlin' },
        root_dir = util.root_pattern(
            'settings.gradle',
            'settings.gradle.kts',
            'build.gradle',
            'build.gradle.kts'
        ),
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
    }
end
