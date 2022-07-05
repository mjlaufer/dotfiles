local util = require('mjlaufer.util')
local opts = require('mjlaufer.lsp.server_options')

local null_ls = util.prequire('null-ls')
if not null_ls then
    return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
    debug = false,
    sources = {formatting.prettier, formatting.lua_format},
    on_attach = opts.on_attach,
})
