require('mjlaufer.git_plugins.blamer')
require('mjlaufer.git_plugins.diffview')

local util = require('mjlaufer.util')

util.useWhichKey({['<leader>g'] = {name = 'Git'}})
