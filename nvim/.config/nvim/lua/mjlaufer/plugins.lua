-- Automatically install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrapping = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrapping = true
    vim.fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })
    vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
    use {'wbthomason/packer.nvim', commit = '6db20b4'}
    use 'lewis6991/impatient.nvim' -- Improves start time.

    -- Plenary is a lua function library that a lot of plugins depend on.
    use {'nvim-lua/plenary.nvim', commit = '4b7e520'}

    -- Colors
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'nvim-treesitter/playground', after = 'nvim-treesitter'}
    use {'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter'}
    use 'mjlaufer/glint.nvim'

    -- LSP
    use {'folke/neodev.nvim', commit = '258b83f'} -- Improve init.lua and plugin DX
    use 'neovim/nvim-lspconfig'
    use {'williamboman/mason.nvim', commit = 'bf170f8'}
    use {'williamboman/mason-lspconfig.nvim', commit = 'a910b4d'}
    use {'jose-elias-alvarez/null-ls.nvim', commit = '8291005'}
    use {'jose-elias-alvarez/nvim-lsp-ts-utils', commit = '0a6a16e'} -- TypeScript development
    -- TODO: Use jose-elias-alvarez/typescript.nvim
    use {'mfussenegger/nvim-jdtls', commit = '69ad133'}
    use {'simrat39/rust-tools.nvim', commit = '99fd123'}
    use {'j-hui/fidget.nvim', commit = '44585a0'} -- UI for LSP installation progress
    use {'glepnir/lspsaga.nvim', branch = 'main', commit = 'f33bc99'} -- LSP UI enhancements
    use {'RRethy/vim-illuminate', commit = '0603e75'} -- Highlights identifier under curor

    -- Completion
    use {'hrsh7th/nvim-cmp', commit = '9bb8ee6'}
    use {'hrsh7th/cmp-nvim-lsp', commit = '78924d1'}
    use {'hrsh7th/cmp-nvim-lsp-signature-help', commit = 'd2768cb'}
    use {'hrsh7th/cmp-buffer', commit = '3022dbc'}
    use {'hrsh7th/cmp-path', commit = '91ff86c'}
    use {'hrsh7th/cmp-nvim-lua', commit = 'd276254'}
    use {'onsails/lspkind-nvim', commit = 'c68b3a0'}
    use {'saadparwaiz1/cmp_luasnip', commit = '1809552'}
    use {'L3MON4D3/LuaSnip', commit = '663d544'}
    use {'rafamadriz/friendly-snippets', commit = 'c93311f'}

    -- Icons used by lualine and nvim-tree
    use {
        'kyazdani42/nvim-web-devicons',
        commit = '9061e2d',
        config = function()
            require('nvim-web-devicons').setup({override = {}, default = true})
        end,
    }

    -- Workspace
    use {'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = {{'nvim-lua/plenary.nvim'}}}
    use {
        'folke/which-key.nvim',
        commit = '61553ae',
        config = function()
            require('which-key').setup({ignore_missing = true})
        end,
    }
    use {'folke/trouble.nvim', commit = 'ed65f84'} -- List for diagnostics, quickfix, and Telescope results
    use {'kyazdani42/nvim-tree.lua', commit = '3845039'}
    use {'nvim-lualine/lualine.nvim', commit = '3325d5d'}
    use {'akinsho/toggleterm.nvim', commit = 'b02a167'}
    use {
        'iamcco/markdown-preview.nvim',
        commit = '02cc387',
        run = 'cd app && yarn install',
        setup = function()
            vim.g.mkdp_filetypes = {'markdown'}
        end,
        ft = 'markdown',
    }
    use {'mbbill/undotree', commit = '1a23ea8'}
    -- Fancy start screen; useful for `:SSave` and `:SLoad` (wrappers for `:mksession`).
    use {
        'mhinz/vim-startify',
        commit = '81e36c3',
        config = function()
            vim.g.startify_disable_at_vimenter = true
        end,
    }

    -- Editor
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use {'tpope/vim-unimpaired', after = 'vim-repeat'}
    use 'tpope/vim-eunuch'
    use 'tpope/vim-characterize'
    use 'tpope/vim-sleuth'
    use {'windwp/nvim-autopairs', commit = '6b6e35f'}
    use {
        'windwp/nvim-ts-autotag',
        commit = '044a05c',
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    }
    use {'numToStr/Comment.nvim', commit = 'ad7ffa8'}
    use {'JoosepAlviste/nvim-ts-context-commentstring', commit = '32d9627'}
    use {'lukas-reineke/indent-blankline.nvim', commit = 'c4c203c'}
    use {'justinmk/vim-sneak', commit = '93395f5'}
    use {'NvChad/nvim-colorizer.lua', commit = '760e27d'}

    -- Git
    use 'tpope/vim-fugitive'
    use {'tpope/vim-rhubarb', after = 'vim-fugitive'} -- GitHub integration
    use {'lewis6991/gitsigns.nvim', commit = '9110ea1'}
    use {'sindrets/diffview.nvim', commit = '94a3422'}

    -- Testing
    use {'nvim-neotest/neotest', commit = '0be9899'}
    use {'haydenmeade/neotest-jest', commit = '2051686'}

    -- DAP
    use {'mfussenegger/nvim-dap', commit = '3d0d731'}
    use {'nvim-telescope/telescope-dap.nvim', commit = 'b4134ff'}
    use {'theHamsta/nvim-dap-virtual-text', commit = '2971ce3'}
    use {'rcarriga/nvim-dap-ui', commit = '111236e'}
    use {'mxsdev/nvim-dap-vscode-js', commit = 'e7c0549'}

    if is_bootstrapping then
        require('packer').sync()
        print '==================================='
        print '    Plugins are being installed.'
        print '    Wait until Packer completes,'
        print '       then restart nvim'
        print '==================================='
    end
end)
