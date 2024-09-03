local util = require('mjlaufer.util')
local map = util.map

require('codecompanion').setup({
    strategies = {
        chat = {
            adapter = 'anthropic',
        },
        inline = {
            adapter = 'anthropic',
        },
        agent = {
            adapter = 'anthropic',
        },
    },
    adapters = {
        anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
                env = {
                    api_key = 'cmd:bw get password anthropic-api-key',
                },
            })
        end,
    },
})

util.useWhichKey({ { '<leader>m', group = 'CodeCompanion' } })

map('n', '<leader>ma', ':CodeCompanionActions<CR>', 'Open action palette')
map('n', '<leader>mt', ':CodeCompanionToggle<CR>', 'Toggle chat buffer')

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
