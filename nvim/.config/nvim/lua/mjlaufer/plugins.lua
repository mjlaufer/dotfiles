local util = require('mjlaufer.util')
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
    print 'Installing packer close and reopen Neovim...'
    vim.cmd [[packadd packer.nvim]]
end

local packer = util.prequire('packer')
if not packer then
    return
end

return packer.startup(function(use)
    use {'wbthomason/packer.nvim', commit = '4dedd3b'}
    use 'lewis6991/impatient.nvim' -- Improves start time.

    -- Plenary is a lua function library that a lot of plugins depend on.
    use {'nvim-lua/plenary.nvim', commit = '46e8bb9'}

    -- Look and Feel
    use {'nvim-treesitter/nvim-treesitter', commit = '7d2bd76', run = ':TSUpdate'}
    use {'nvim-treesitter/playground', commit = 'ce7e4b7'}
    use 'mjlaufer/glint.nvim'
    use {
        'kyazdani42/nvim-web-devicons',
        commit = '8d2c533',
        config = function()
            require('nvim-web-devicons').setup({override = {}, default = true})
        end,
    } -- Used by lualine and nvim-tree.
    use {'psliwka/vim-smoothie', commit = 'df1e324'} -- Smooth scrolling for `C-d`, etc.
    use {
        'mhinz/vim-startify',
        commit = '81e36c3',
        config = function()
            vim.g.startify_disable_at_vimenter = true
        end,
    } -- Fancy start screen; useful for `:SSave` and `:SLoad` (wrappers for `:mksession`).
    use {'norcalli/nvim-colorizer.lua', commit = '36c610a'}

    -- Editor
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use {'tpope/vim-unimpaired', after = 'vim-repeat'}
    use 'tpope/vim-characterize'
    use {'windwp/nvim-autopairs', commit = '4a95b39'}
    use {
        'windwp/nvim-ts-autotag',
        commit = '044a05c',
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    }
    use {'numToStr/Comment.nvim', commit = '4086630'}
    use {'JoosepAlviste/nvim-ts-context-commentstring', commit = '8834375'}
    use {'justinmk/vim-sneak', commit = '94c2de4'}

    -- Workspace
    use {'nvim-telescope/telescope.nvim', commit = 'b79cd6c'}
    use {
        'folke/which-key.nvim',
        commit = 'bd4411a',
        config = function()
            require('which-key').setup({ignore_missing = true})
        end,
    }
    use {'folke/trouble.nvim', commit = 'da61737'} -- List for diagnostics, quickfix, and Telescope results
    use {'kyazdani42/nvim-tree.lua', commit = '19dcacf'}
    use {'nvim-lualine/lualine.nvim', commit = '5113cdb'}
    use {'akinsho/toggleterm.nvim', commit = '04174e1'}
    use {
        'iamcco/markdown-preview.nvim',
        commit = '02cc387',
        run = 'cd app && yarn install',
        setup = function()
            vim.g.mkdp_filetypes = {'markdown'}
        end,
        ft = 'markdown',
    }

    -- Git
    use 'tpope/vim-fugitive'
    use {'tpope/vim-rhubarb', after = 'vim-fugitive'} -- GitHub integration
    use {'lewis6991/gitsigns.nvim', commit = '4883988'}
    use {'sindrets/diffview.nvim', commit = '2d1f452'}

    -- LSP
    use 'neovim/nvim-lspconfig'
    use {'williamboman/nvim-lsp-installer', commit = 'cd4dac0'}
    -- TODO: Use williamboman/mason.nvim
    use {'jose-elias-alvarez/null-ls.nvim', commit = 'a2b7bf8'}
    use {'jose-elias-alvarez/nvim-lsp-ts-utils', commit = '1826275'} -- TypeScript development
    -- TODO: Use jose-elias-alvarez/typescript.nvim
    use {'glepnir/lspsaga.nvim', branch = 'main', commit = 'f404125'} -- LSP UI enhancements
    use {'stevearc/aerial.nvim', commit = '4b4ada8'} -- Symbol outline window

    -- Completion
    use {'hrsh7th/nvim-cmp', commit = 'df6734a'}
    use {'hrsh7th/cmp-nvim-lsp', commit = 'ebdfc20'}
    use {'hrsh7th/cmp-buffer', commit = 'd66c4c2'}
    use {'hrsh7th/cmp-path', commit = '466b6b8'}
    use {'hrsh7th/cmp-nvim-lua', commit = 'd276254'}
    use {'onsails/lspkind-nvim', commit = '57e5b5d'}

    -- Snippets
    use {'saadparwaiz1/cmp_luasnip', commit = 'b108297'}
    use {'L3MON4D3/LuaSnip', commit = '7fc4f14'}
    use {'rafamadriz/friendly-snippets', commit = '6e0881a'}

    -- Testing
    use {'nvim-neotest/neotest', commit = '7e13978'}
    use {'haydenmeade/neotest-jest', commit = '0e20fad'}

    -- Debugger
    use {'mfussenegger/nvim-dap', commit = 'd6d8317'}
    use {'nvim-telescope/telescope-dap.nvim', commit = 'b4134ff'}
    use {'theHamsta/nvim-dap-virtual-text', commit = '10368a1'}
    use {'rcarriga/nvim-dap-ui', commit = '3eec525'}

    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
