require('mjlaufer.git_plugins.blamer')
require('mjlaufer.git_plugins.diffview')

local useWhichKey = require('mjlaufer.util').useWhichKey

useWhichKey({['<leader>g'] = {name = 'Git'}})
