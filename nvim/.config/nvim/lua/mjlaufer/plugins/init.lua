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
    -- Colors
    {
        'mjlaufer/flashy.nvim',
        config = function()
            vim.cmd [[
                set termguicolors " Enable True Color support.
                set background=dark
                colorscheme flashy
                let g:markdown_fenced_languages = [
                    \ 'html',
                    \ 'sh', 'bash=sh',
                    \ 'java',
                    \ 'javascript', 'js=javascript',
                    \ 'typescript', 'ts=typescript',
                    \ 'lua',
                    \ 'rust']
            ]]
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
    {'nvim-treesitter/playground', pin = true},
    {'nvim-treesitter/nvim-treesitter-textobjects', pin = true},
    {
        -- Icons used by lualine and nvim-tree
        'kyazdani42/nvim-web-devicons',
        pin = true,
        config = function()
            require('nvim-web-devicons').setup({override = {}, default = true})
        end,
    },

    -- Plenary is a lua function library that a lot of plugins depend on.
    {'nvim-lua/plenary.nvim', pin = true},

    -- LSP
    {
        -- Neodev improves init.lua and plugin DX; must be set up before LSP config.
        'folke/neodev.nvim',
        pin = true,
        config = function()
            require('neodev').setup()
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'williamboman/mason.nvim', pin = true},
            {'williamboman/mason-lspconfig.nvim', pin = true},
            {'jose-elias-alvarez/null-ls.nvim', pin = true},
            -- TypeScript development
            -- TODO: jose-elias-alvarez/typescript.nvim
            {'jose-elias-alvarez/nvim-lsp-ts-utils', pin = true},
            {'simrat39/rust-tools.nvim', pin = true},
        },
        config = function()
            require('mjlaufer.plugins.lsp')
        end,
    },
    {'mfussenegger/nvim-jdtls', pin = true},
    {
        -- UI for LSP installation progress
        'j-hui/fidget.nvim',
        tag = 'legacy',
        pin = true,
        config = function()
            require('fidget').setup()
        end,
    },
    {'RRethy/vim-illuminate', pin = true}, -- Highlights identifier under curor

    -- Completion
    {
        'hrsh7th/nvim-cmp',
        pin = true,
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp', pin = true},
            {'hrsh7th/cmp-nvim-lsp-signature-help', pin = true},
            {'hrsh7th/cmp-buffer', pin = true},
            {'hrsh7th/cmp-path', pin = true},
            {'hrsh7th/cmp-nvim-lua', pin = true},
            {'onsails/lspkind-nvim', pin = true},
            {'saadparwaiz1/cmp_luasnip', pin = true},
            {'L3MON4D3/LuaSnip', pin = true},
            {'rafamadriz/friendly-snippets', pin = true},
        },
        config = function()
            require('mjlaufer.plugins.cmp')
        end,
    },

    -- Workspace
    {
        'folke/which-key.nvim',
        pin = true,
        config = function()
            require('which-key').setup({ignore_missing = true})
        end,
    },
    {
        -- List for diagnostics, quickfix, and Telescope results
        'folke/trouble.nvim',
        pin = true,
        config = function()
            require('mjlaufer.plugins.trouble')
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        config = function()
            require('mjlaufer.plugins.telescope')
        end,
    },
    {
        'kyazdani42/nvim-tree.lua',
        pin = true,
        config = function()
            require('mjlaufer.plugins.nvim_tree')
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        pin = true,
        config = function()
            require('mjlaufer.plugins.lualine')
        end,
    },
    {
        'akinsho/toggleterm.nvim',
        pin = true,
        config = function()
            require('mjlaufer.plugins.toggleterm')
        end,
    },
    {
        'iamcco/markdown-preview.nvim',
        pin = true,
        build = 'cd app && yarn install',
        init = function()
            vim.g.mkdp_filetypes = {'markdown'}
        end,
        ft = 'markdown',
    },
    {
        'mbbill/undotree',
        pin = true,
        config = function()
            require('mjlaufer.plugins.undotree')
        end,
    },
    {
        -- Fancy start screen; useful for `:SSave` and `:SLoad` (wrappers for `:mksession`).
        'mhinz/vim-startify',
        pin = true,
        config = function()
            vim.g.startify_disable_at_vimenter = true
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
        'windwp/nvim-autopairs',
        pin = true,
        config = function()
            require('nvim-autopairs').setup({
                check_ts = true,
                ts_config = {lua = {'string', 'source'}, javascript = {'string', 'template_string'}},
            })
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },
    {
        'windwp/nvim-ts-autotag',
        pin = true,
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    },
    {
        'numToStr/Comment.nvim',
        pin = true,
        dependencies = {{'JoosepAlviste/nvim-ts-context-commentstring', pin = true}},
        config = function()
            require('mjlaufer.plugins.comment')
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        pin = true,
        config = function()
            require('indent_blankline').setup({show_current_context = true})
        end,
    },
    {
        'justinmk/vim-sneak',
        pin = true,
        config = function()
            require('mjlaufer.plugins.sneak')
        end,
    },
    {
        'NvChad/nvim-colorizer.lua',
        pin = true,
        config = function()
            require('colorizer').setup({filetypes = {'*', css = {rgb_fn = true, hsl_fn = true}}})
        end,
    },

    -- Git
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb', -- GitHub integration
    {
        'lewis6991/gitsigns.nvim',
        pin = true,
        config = function()
            require('mjlaufer.plugins.gitsigns')
        end,
    },
    {
        'sindrets/diffview.nvim',
        pin = true,
        config = function()
            require('mjlaufer.plugins.diffview')
        end,
    },

    -- Testing
    {
        'nvim-neotest/neotest',
        pin = true,
        dependencies = {{'haydenmeade/neotest-jest', pin = true}},
        config = function()
            require('mjlaufer.plugins.neotest')
        end,
    },

    -- DAP
    {
        'mfussenegger/nvim-dap',
        pin = true,
        dependencies = {
            {'nvim-telescope/telescope-dap.nvim', pin = true},
            {'theHamsta/nvim-dap-virtual-text', pin = true},
            {'rcarriga/nvim-dap-ui', pin = true},
            {'mxsdev/nvim-dap-vscode-js', pin = true},
        },
        config = function()
            require('mjlaufer.plugins.dap')
        end,
    },

    -- Writing
    {
        'folke/zen-mode.nvim',
        pin = true,
        opts = {
            window = {
                backdrop = 1,
                width = 100,
                options = {signcolumn = 'auto', number = true, relativenumber = true},
            },
            plugins = {
                twilight = {enabled = true},
                gitsigns = {enabled = false},
                tmux = {enabled = false},
                kitty = {enabled = true, font = '+4'},
            },
        },
    },
    {'folke/twilight.nvim', pin = true, opts = {dimming = {alpha = 0.5}, context = 12}},
}, {dev = {path = '~/personal'}})
