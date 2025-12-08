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
    { 'nvim-mini/mini.ai', version = '*', opts = {} },
    { 'nvim-mini/mini.bracketed', version = '*', opts = {} },
    { 'nvim-mini/mini.splitjoin', version = '*', opts = {} },
    {
        'nvim-mini/mini.surround',
        version = '*',
        config = function()
            require('mini.surround').setup({
                mappings = {
                    add = 'ys', -- Add surrounding: ys{motion}{char}
                    delete = 'ds', -- Delete surrounding: ds{char}
                    replace = 'cs', -- Change surrounding: cs{old}{new}
                    find = '',
                    find_left = '',
                    highlight = '',
                    update_n_lines = '',
                },
            })

            -- `yS` => surround to end-of-line
            vim.keymap.set('n', 'yS', 'ys$', { remap = true, silent = true })
            -- `yss` => surround the whole current line.
            vim.keymap.set('n', 'yss', '^ys$', { remap = true, silent = true })
        end,
    },
    'tpope/vim-characterize', -- Enhances `ga`, which displays a character's representation in decimal, octal, and hex.
    'tpope/vim-eunuch', -- Vim sugar for Unix shell commands (e.g., `:Chmod`).
    'justinmk/vim-gtfo',
    {
        'justinmk/vim-sneak',
        init = function()
            vim.g['sneak#prompt'] = ''
            vim.g['sneak#label'] = 1
        end,
        config = function()
            require('mjlaufer.plugins.sneak')
        end,
    },
}

require('lazy').setup(IS_VSCODE and core_editor_plugins or vim.list_extend(core_editor_plugins, {
    'nvim-lua/plenary.nvim', -- Lua function library that a lot of plugins depend on.
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
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
            scroll = { enabled = true },
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
        'nvim-tree/nvim-web-devicons', -- Icons used by nvim-tree, oil, and lualine
        opts = { override = {}, default = true },
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason.nvim',
                opts = {},
            },
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
            'hrsh7th/cmp-cmdline',
            'onsails/lspkind-nvim',
            'saadparwaiz1/cmp_luasnip',
            {
                'L3MON4D3/LuaSnip', -- snippet engine
                version = 'v2.*',
                build = 'make install_jsregexp',
            },
        },
        config = function()
            require('mjlaufer.plugins.cmp')
        end,
    },

    -- Workspace
    {
        'nvim-mini/mini.bufremove',
        version = '*',
        opts = {},
        keys = {
            {
                '<leader>bd',
                function()
                    require('mini.bufremove').delete(0, false)
                end,
                desc = 'Delete current buffer',
            },
        },
    },
    {
        'nvim-mini/mini.clue',
        version = '*',
        opts = function()
            local miniclue = require('mini.clue')
            return {
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },

                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Prev/Next
                    { mode = 'n', keys = '[' },
                    { mode = 'n', keys = ']' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },
                },
                clues = {
                    -- Leader/movement groups.
                    { mode = 'n', keys = '[', desc = '+prev' },
                    { mode = 'n', keys = ']', desc = '+next' },
                    { mode = 'n', keys = '<leader>a', desc = '+LSP' },
                    { mode = 'n', keys = '<leader>b', desc = '+Buffers' },
                    { mode = 'n', keys = '<leader>c', desc = '+Code' },
                    { mode = 'n', keys = '<leader>d', desc = '+Debug' },
                    { mode = 'n', keys = '<leader>e', desc = '+Explorer' },
                    { mode = 'n', keys = '<leader>f', desc = '+Find' },
                    { mode = 'n', keys = '<leader>g', desc = '+Git' },
                    { mode = 'n', keys = '<leader>l', desc = '+Location list' },
                    { mode = 'n', keys = '<leader>r', desc = 'Replace' },
                    { mode = 'n', keys = '<leader>T', desc = 'Toggle terminal layout' },
                    { mode = 'n', keys = '<leader>t', desc = '+Test' },
                    { mode = 'n', keys = '<leader>u', desc = 'Undotree' },

                    -- Builtins.
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                },
                window = {
                    delay = 500,
                    config = {
                        width = 'auto',
                    },
                },
            }
        end,
    },
    {
        'ibhagwan/fzf-lua',
        config = function()
            require('mjlaufer.plugins.fzf-lua')
        end,
    },
    {
        'nvim-tree/nvim-tree.lua',
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
        'mbbill/undotree',
        config = function()
            require('mjlaufer.plugins.undotree')
        end,
    },
    {
        'MagicDuck/grug-far.nvim',
        cmd = 'GrugFar',
        keys = {
            {
                '<leader>cg',
                function()
                    require('grug-far').open({ transient = true })
                end,
                desc = 'GrugFar',
                mode = { 'n', 'v' },
            },
        },
        opts = {},
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
        'catgoose/nvim-colorizer.lua',
        opts = { filetypes = { '*', css = { rgb_fn = true, hsl_fn = true } } },
    },

    -- Git
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
    {
        'linrongbin16/gitlinker.nvim',
        cmd = 'GitLink',
        opts = {},
        keys = {
            { '<leader>gy', '<cmd>GitLink<CR>', mode = { 'n', 'v' }, desc = 'Yank git link' },
            {
                '<leader>gY',
                '<cmd>GitLink! blame<CR>',
                mode = { 'n', 'v' },
                desc = 'Open git link',
            },
        },
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
        'OXY2DEV/markview.nvim',
        lazy = false,
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
}), { pin = true, dev = { path = '~/personal' } })
