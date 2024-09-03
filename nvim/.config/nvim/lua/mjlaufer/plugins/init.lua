-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Plenary is a lua function library that a lot of plugins depend on.
    'nvim-lua/plenary.nvim',

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
        -- Icons used by lualine and nvim-tree
        'kyazdani42/nvim-web-devicons',
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
            'jose-elias-alvarez/typescript.nvim',
            -- TODO: Replace rust-tools.nvim with rustaceanvim.
            -- { 'mrcjkb/rustaceanvim', version = '^4', ft = { 'rust' } },
            'simrat39/rust-tools.nvim',
        },
        config = function()
            require('mjlaufer.plugins.lsp')
        end,
    },
    'mfussenegger/nvim-jdtls',
    {
        -- UI for LSP installation progress
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = function()
            require('fidget').setup()
        end,
    },
    'RRethy/vim-illuminate', -- Highlights identifier under curor
    {
        -- Completion
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'onsails/lspkind-nvim',
            'saadparwaiz1/cmp_luasnip',
            { 'L3MON4D3/LuaSnip', run = 'make install_jsregexp' },
            'rafamadriz/friendly-snippets',
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
        tag = '0.1.4',
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
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'tpope/vim-unimpaired',
    'tpope/vim-eunuch',
    'tpope/vim-characterize',
    'tpope/vim-sleuth',
    'tpope/vim-abolish',
    {
        'stevearc/conform.nvim',
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    c = { 'clang_format' },
                    css = { 'prettier' },
                    html = { 'prettier' },
                    java = { 'google-java-format' },
                    javascript = { 'prettier' },
                    javascriptreact = { 'prettier' },
                    lua = { 'stylua' },
                    markdown = { 'prettier' },
                    rust = { 'rustfmt' },
                    typescript = { 'prettier' },
                    typescriptreact = { 'prettier' },
                },
                format_after_save = {
                    lsp_fallback = false,
                },
            })
            local util = require('conform.util')
            util.add_formatter_args(require('conform.formatters.google-java-format'), { '--aosp' })
        end,
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
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    },
    {
        'numToStr/Comment.nvim',
        dependencies = {
            {
                'JoosepAlviste/nvim-ts-context-commentstring',
                config = function()
                    require('ts_context_commentstring').setup({
                        enable_autocmd = false,
                    })
                end,
            },
        },
        config = function()
            require('Comment').setup({
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            })
        end,
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

    -- Debug/test
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
    {
        'nvim-neotest/neotest',
        dependencies = { 'haydenmeade/neotest-jest' },
        config = function()
            require('mjlaufer.plugins.neotest')
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
