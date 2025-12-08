local util = require('mjlaufer.util')
local map = vim.keymap.set

local jdtls = require('jdtls')

local os_name
if vim.fn.has('mac') == 1 then
    os_name = 'mac'
elseif vim.fn.has('unix') == 1 then
    os_name = 'linux'
end

local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls/'
local root_dir = require('jdtls.setup').find_root({ '.git', 'gradlew', 'mvnw' })
local project_data_dir = vim.env.HOME
    .. '/.local/share/eclipse/'
    .. vim.fn.fnamemodify(root_dir, ':p:h:t')

-- Create a list of paths to JAR files for debug and test.
local java_debug_jar_path = vim.fn.stdpath('data')
    .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar'
local java_debug_bundles = vim.split(vim.fn.glob(java_debug_jar_path), '\n')
local java_test_jar_path = vim.fn.stdpath('data')
    .. '/mason/packages/java-test/extension/server/*.jar'
local java_test_bundles = vim.split(vim.fn.glob(java_test_jar_path), '\n')
local bundles = {}
vim.list_extend(bundles, java_debug_bundles)
vim.list_extend(bundles, java_test_bundles)

-- See 'mjlaufer.plugins.lsp`.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities =
    vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
    cmd = {
        'java', -- path to Java 17 or newer
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        vim.fn.glob(jdtls_path .. 'plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration',
        jdtls_path .. 'config_' .. os_name,
        '-data',
        project_data_dir,
    },
    root_dir = root_dir,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
                favoriteStaticMembers = {
                    'org.hamcrest.MatcherAssert.assertThat',
                    'org.hamcrest.Matchers.*',
                    'org.hamcrest.CoreMatchers.*',
                    'org.junit.jupiter.api.Assertions.*',
                    'java.util.Objects.requireNonNull',
                    'java.util.Objects.requireNonNullElse',
                    'org.mockito.Mockito.*',
                },
            },
            sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
            codeGeneration = {
                toString = {
                    template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                },
                useBlocks = true,
            },
        },
    },
    on_attach = function(_, bufnr)
        -- DAP setup
        jdtls.setup_dap({ hotcodereplace = 'auto' })
        jdtls.setup.add_commands()

        map('n', '<leader>ro', jdtls.organize_imports, { buffer = bufnr, desc = 'Organize imports' })
        map('n', '<leader>rv', jdtls.extract_variable, { buffer = bufnr, desc = 'Extract variable' })
        map('n', '<leader>rc', jdtls.extract_constant, { buffer = bufnr, desc = 'Extract constant' })
        map('x', 'rv', [[<esc><cmd>lua require('jdtls').extract_variable(true)<CR>]], { buffer = bufnr })
        map('x', 'rc', [[<esc><cmd>lua require('jdtls').extract_constant(true)<CR>]], { buffer = bufnr })
        map('x', 'rm', [[<esc><cmd>lua require('jdtls').extract_method(true)<CR>]], { buffer = bufnr })
        map('n', '<leader>sc', jdtls.test_class, { buffer = bufnr, desc = 'Test class' })
        map('n', '<leader>sm', jdtls.test_nearest_method, { buffer = bufnr, desc = 'Test nearest method' })
    end,
    capabilities = capabilities,
    init_options = { bundles = bundles, extendedClientCapabilities = extendedClientCapabilities },
}

jdtls.start_or_attach(config)
