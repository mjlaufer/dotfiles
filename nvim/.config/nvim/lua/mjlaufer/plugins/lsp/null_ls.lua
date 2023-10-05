local opts = require('mjlaufer.plugins.lsp.server_options')

local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting

null_ls.setup({
    debug = false,
    sources = {
        formatting.prettier,
        formatting.google_java_format.with({ extra_args = { '--aosp' } }),
        formatting.stylua,
        formatting.rustfmt,
    },
    on_attach = opts.on_attach,
})
