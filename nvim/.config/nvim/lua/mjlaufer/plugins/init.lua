-- Bootstrap lazy.nvim. See `:help lazy.nvim.txt`.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable', -- latest stable release
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'nvim-lua/plenary.nvim', -- Lua function library that a lot of plugins depend on.

    -- Colors
    {
        'mjlaufer/flashy.nvim',
        config = function()
            vim.cmd([[
                set termguicolors " Enable True Color support.
                set background=dark
                colorscheme flashy
                let g:markdown_fenced_languages = [
                    \ 'sh', 'bash=sh',
                    \ 'c',
                    \ 'go',
                    \ 'html',
                    \ 'java',
                    \ 'javascript', 'js=javascript',
                    \ 'lua',
                    \ 'rust',
                    \ 'typescript', 'ts=typescript']
            ]])
        end,
        priority = 1000,
        dev = false,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('mjlaufer.plugins.treesitter')
        end,
    },
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
        'kyazdani42/nvim-web-devicons', -- Icons used by lualine and nvim-tree
        config = function()
            require('nvim-web-devicons').setup({ override = {}, default = true })
        end,
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            {
                'j-hui/fidget.nvim', -- UI for LSP installation progress
                opts = {},
            },
            'yioneko/nvim-vtsls',
            'b0o/schemastore.nvim',
            -- TODO: Add mrcjkb/rustaceanvim.
        },
        config = function()
            require('mjlaufer.plugins.lsp')
        end,
    },
    'mfussenegger/nvim-jdtls',

    -- Completion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'onsails/lspkind-nvim',
            'saadparwaiz1/cmp_luasnip',
            {
                'L3MON4D3/LuaSnip', -- snippet engine
                run = 'make install_jsregexp',
                dependencies = {
                    'rafamadriz/friendly-snippets', -- contains a variety of premade snippets
                },
            },
        },
        config = function()
            require('mjlaufer.plugins.cmp')
        end,
    },

    -- Workspace
    {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup({
                filter = function(mapping)
                    return mapping.desc and mapping.desc ~= ''
                end,
            })
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        config = function()
            require('mjlaufer.plugins.telescope')
        end,
    },
    {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require('mjlaufer.plugins.nvim_tree')
        end,
    },
    {
        'stevearc/oil.nvim',
        config = function()
            require('mjlaufer.plugins.oil')
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('mjlaufer.plugins.lualine')
        end,
    },
    {
        'akinsho/toggleterm.nvim',
        config = function()
            require('mjlaufer.plugins.toggleterm')
        end,
    },
    {
        'mbbill/undotree',
        config = function()
            require('mjlaufer.plugins.undotree')
        end,
    },

    -- Editor
    'tpope/vim-surround', -- Provides maps for working with parens, brackets, tags, etc.
    'tpope/vim-repeat',
    'tpope/vim-unimpaired',
    'tpope/vim-eunuch',
    'tpope/vim-characterize',
    'tpope/vim-sleuth', -- Adjusts `shiftwidth` and `expandtab` automatically
    'tpope/vim-abolish',
    {
        'stevearc/conform.nvim',
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    c = { 'clang_format' },
                    css = { 'biome', 'prettier', stop_after_first = true },
                    html = { 'prettier' },
                    java = { 'google-java-format' },
                    javascript = { 'biome', 'prettier', stop_after_first = true },
                    javascriptreact = { 'biome', 'prettier', stop_after_first = true },
                    json = { 'biome', 'prettier', stop_after_first = true },
                    lua = { 'stylua' },
                    markdown = { 'prettier' },
                    rust = { 'rustfmt' },
                    typescript = { 'biome', 'prettier', stop_after_first = true },
                    typescriptreact = { 'biome', 'prettier', stop_after_first = true },
                },
                format_on_save = {
                    lsp_format = 'fallback',
                    timeout_ms = 2000,
                },
            })
            local util = require('conform.util')
            util.add_formatter_args(require('conform.formatters.google-java-format'), { '--aosp' })
        end,
    },
    {
        'folke/ts-comments.nvim',
        opts = {},
        event = 'VeryLazy',
        enabled = vim.fn.has('nvim-0.10.0') == 1,
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({
                check_ts = true,
                ts_config = {
                    lua = { 'string', 'source' },
                    javascript = { 'string', 'template_string' },
                },
            })
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },
    {
        'windwp/nvim-ts-autotag',
        opts = {},
    },
    {
        'justinmk/vim-sneak',
        config = function()
            require('mjlaufer.plugins.sneak')
        end,
    },
    {
        'iamcco/markdown-preview.nvim',
        build = 'cd app && yarn install',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = 'markdown',
    },
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup({
                filetypes = { '*', css = { rgb_fn = true, hsl_fn = true } },
            })
        end,
    },

    -- Git
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb', -- GitHub integration
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('mjlaufer.plugins.gitsigns')
        end,
    },
    {
        'sindrets/diffview.nvim',
        config = function()
            require('mjlaufer.plugins.diffview')
        end,
    },

    -- Debug
    'nvim-neotest/nvim-nio',
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'nvim-telescope/telescope-dap.nvim',
            'theHamsta/nvim-dap-virtual-text',
            'rcarriga/nvim-dap-ui',
        },
        config = function()
            require('mjlaufer.plugins.dap')
        end,
    },

    -- LLM support
    {
        'olimorris/codecompanion.nvim',
        config = function()
            require('mjlaufer.plugins.codecompanion')
        end,
    },
}, { pin = true, dev = { path = '~/personal' } })
