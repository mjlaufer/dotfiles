require('luasnip/loaders/from_vscode').lazy_load()

local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    completion = { completeopt = 'menu,menuone,noinsert,noselect', autoselect = false },
    window = {
        -- For documentation, use dark background with border.
        documentation = cmp.config.window.bordered({
            winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Confirm explicitly selected item.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer', keyword_length = 3 },
    }),
    formatting = {
        format = require('lspkind').cmp_format({
            with_text = true,
            menu = {
                nvim_lsp = '[LSP]',
                nvim_lua = '[NvimApi]',
                luasnip = '[LuaSnip]',
                path = '[Path]',
                buffer = '[Buf]',
            },
            maxwidth = 50,
        }),
    },
    -- Search completion
    cmp.setup.cmdline(
        '/',
        { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } }
    ),
    -- Command completion
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
    }),
})
