require('codecompanion').setup({
    strategies = {
        chat = {
            adapter = 'copilot',
        },
        inline = {
            adapter = 'copilot',
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

-- Expand CodeCompanion[...] commands.
vim.cmd([[cab cc CodeCompanion]])
vim.cmd([[cab cca CodeCompanionActions]])
vim.cmd([[cab ccc CodeCompanionChat]])
