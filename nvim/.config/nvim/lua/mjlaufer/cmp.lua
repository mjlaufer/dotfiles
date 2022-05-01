vim.cmd([[
    " Completion menu options
    set completeopt=menu,menuone,noselect
    let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
]])

local util = require('mjlaufer.util')

local cmp = util.prequire('cmp')
local luasnip = util.prequire('luasnip')
if (not cmp or not luasnip) then
    return
end

require('luasnip/loaders/from_vscode').lazy_load()
require('luasnip/loaders/from_vscode').lazy_load({
    paths = {'~/.local/share/nvim/site/pack/packer/start/friendly-snippets'},
})

local lspkind = require('lspkind')

local check_backspace = function()
    local col = vim.fn.col '.' - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'}),
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
        {name = 'luasnip'},
        {name = 'path'},
    }, {{name = 'buffer', keyword_length = 5}}),
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                nvim_lsp = '[LSP]',
                nvim_lua = '[VimApi]',
                luasnip = '[Snip]',
                path = '[Path]',
                buffer = '[Buf]',
            },
            maxwidth = 50,
        }),
    },
    cmp.setup.cmdline('/', {mapping = cmp.mapping.preset.cmdline(), sources = {{name = 'buffer'}}}),
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}}),
    }),
})
