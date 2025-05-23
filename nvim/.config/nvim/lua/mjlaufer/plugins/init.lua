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

local core_editor_plugins = {
    'tpope/vim-surround', -- Provides maps for working with parens, brackets, tags, etc.
    'tpope/vim-unimpaired', -- Provides maps for complementary pairs (e.g., `]q` for `:cnext` and `[q` for `:cprevious`).
    'tpope/vim-repeat', -- Applies `.` to vim-surround and vim-unimpaired.
    'tpope/vim-eunuch', -- Vim sugar for Unix shell commands (e.g., `:Chmod`).
    'tpope/vim-characterize', -- Enhances `ga`, which displays a character's representation in decimal, octal, and hex.
    'tpope/vim-sleuth', -- Adjusts `shiftwidth` and `expandtab` automatically
    { 'echasnovski/mini.ai', version = '*', opts = {} },
    {
        'justinmk/vim-sneak',
        config = function()
            require('mjlaufer.plugins.sneak')
        end,
    },
}

require('lazy').setup(IS_VSCODE and core_editor_plugins or vim.list_extend(core_editor_plugins, {
    'nvim-lua/plenary.nvim', -- Lua function library that a lot of plugins depend on.
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
        },
    },

    -- UI
    {
        'mjlaufer/inklight.nvim',
        config = function()
            vim.cmd([[
                set termguicolors " Enable True Color support.
                set background=light
                colorscheme inklight
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
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
        'kyazdani42/nvim-web-devicons', -- Icons used by lualine and nvim-tree
        opts = { override = {}, default = true },
    },
    { 'karb94/neoscroll.nvim', opts = { duration_multiplier = 0.5 } },

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
            'b0o/schemastore.nvim',
        },
        config = function()
            require('mjlaufer.plugins.lsp')
        end,
    },
    'mfussenegger/nvim-jdtls',
    'RRethy/vim-illuminate',

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
    {
        'stevearc/conform.nvim',
        config = function()
            require('mjlaufer.plugins.conform')
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
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' },
        build = 'cd app && yarn install && git restore .',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = 'markdown',
    },
    {
        'catgoose/nvim-colorizer.lua',
        opts = { filetypes = { '*', css = { rgb_fn = true, hsl_fn = true } } },
    },

    -- Git
    'tpope/vim-fugitive',
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

    -- Debug + Test
    'nvim-neotest/nvim-nio', -- Dependency for neotest and nvim-dap-ui
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            { 'theHamsta/nvim-dap-virtual-text', opts = {} },
        },
        config = function()
            require('mjlaufer.plugins.dap')
        end,
    },
    {
        'nvim-neotest/neotest',
        dependencies = {
            'antoinemadec/FixCursorHold.nvim',
            'fredrikaverpil/neotest-golang',
        },
        config = function()
            require('mjlaufer.plugins.neotest')
        end,
    },

    -- Language-specific tools (non-LSP)
    {
        'olexsmir/gopher.nvim',
        ft = 'go',
        ---@type gopher.Config
        opts = {
            commands = {
                go = 'go',
                gomodifytags = 'gomodifytags',
                gotests = 'gotests',
                impl = 'impl',
                iferr = 'iferr',
            },
        },
    },

    -- LLM support
    'github/copilot.vim',
    {
        'olimorris/codecompanion.nvim',
        config = function()
            require('mjlaufer.plugins.codecompanion')
        end,
    },
}), { pin = true, dev = { path = '~/personal' } })
