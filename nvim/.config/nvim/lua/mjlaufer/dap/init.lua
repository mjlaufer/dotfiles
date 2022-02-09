local util = require('mjlaufer.util')

local dap_install = util.prequire('dap-install')
if not dap_install then
    return
end

dap_install.config('chrome', {})
dap_install.config('jsnode', {})

require('mjlaufer.dap.config')
require('mjlaufer.dap.dap_virtual_text')
require('mjlaufer.dap.dap_ui')
