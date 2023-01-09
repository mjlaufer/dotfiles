local util = require('mjlaufer.util')

-- Set up `impatient` before any other lua plugin.
util.prequire('impatient')

require('mjlaufer.globals')
require('mjlaufer.options')
require('mjlaufer.keymaps')
require('mjlaufer.plugins')
require('mjlaufer.theme')
require('mjlaufer.lsp')
require('mjlaufer.dap')
