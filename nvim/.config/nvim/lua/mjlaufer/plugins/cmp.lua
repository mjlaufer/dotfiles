vim.cmd [[
    " Completion menu options
    set completeopt=menu,menuone,noselect
    let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
]]

require('luasnip/loaders/from_vscode').lazy_load()
require('luasnip/loaders/from_vscode').lazy_load({
    paths = {'~/.local/share/nvim/site/pack/packer/start/friendly-snippets'},
})

local formatting = {};
formatting.format = require('lspkind').cmp_format({
    with_text = true,
    menu = {
        nvim_lsp = '[LSP]',
        nvim_lua = '[NvimApi]',
        luasnip = '[LuaSnip]',
        path = '[Path]',
        buffer = '[Buf]',
    },
    maxwidth = 50,
})

local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        documentation = cmp.config.window.bordered({
            winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = false}),
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp_signature_help'},
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
        {name = 'luasnip'},
        {name = 'path'},
        {name = 'buffer', keyword_length = 3},
    }),
    formatting = formatting,
    cmp.setup.cmdline('/', {mapping = cmp.mapping.preset.cmdline(), sources = {{name = 'buffer'}}}),
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}}),
    }),
})
