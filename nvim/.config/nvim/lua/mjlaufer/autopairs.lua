local util = require('mjlaufer.util')

local autopairs = util.prequire('nvim-autopairs')
if not autopairs then
    return
end

autopairs.setup {
    check_ts = true,
    ts_config = {lua = {'string', 'source'}, javascript = {'string', 'template_string'}},
}

-- Allow autopairs to work with cmp.
local cmp = util.prequire('cmp')
if not cmp then
    return
end

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done {map_char = {tex = ''}})
