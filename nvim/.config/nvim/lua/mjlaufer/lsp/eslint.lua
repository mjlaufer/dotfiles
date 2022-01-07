local opts = require('mjlaufer/lsp/server-options')

return {settings = {format = false}, on_attach = opts.on_attach, capabilities = opts.capabilities}
