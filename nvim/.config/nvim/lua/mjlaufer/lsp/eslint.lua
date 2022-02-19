local opts = require('mjlaufer/lsp/server_options')

return {settings = {format = false}, on_attach = opts.on_attach, capabilities = opts.capabilities}
