local opts = require('mjlaufer.lsp.server_options')

return {on_attach = opts.on_attach, capabilites = opts.capabilities}
