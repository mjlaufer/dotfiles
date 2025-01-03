require('luasnip.loaders.from_vscode').lazy_load({
    paths = { vim.fn.expand('~/dotfiles/nvim/.config/nvim/lua/mjlaufer/snippets') },
})

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    -- Enable luasnip to handle snippet expansion for nvim-cmp.
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = { completeopt = 'menu,menuone,noinsert' },
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
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer', keyword_length = 3 },
        { name = 'path' },
    }),
    formatting = {
        format = require('lspkind').cmp_format({
            with_text = true,
            menu = {
                buffer = '[buf]',
                luasnip = '[snip]',
                nvim_lsp = '[LSP]',
                nvim_lua = '[Nvim]',
                path = '[path]',
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
