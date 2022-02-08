local util = require('mjlaufer.util')
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
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
    use {'wbthomason/packer.nvim', commit = '7182f0d'}

    -- Colors
    use {'nvim-treesitter/nvim-treesitter', commit = 'a7c0c17', run = ':TSUpdate'}
    use {'nvim-treesitter/playground', commit = '787a7a8'}
    use 'mjlaufer/undercity.nvim'

    -- Icons (used by lualine and nvim-tree)
    use {
        'kyazdani42/nvim-web-devicons',
        commit = '634e268',
        config = function()
            require('nvim-web-devicons').setup({override = {}, default = true})
        end,
    }

    -- Editor
    use 'tpope/vim-surround'
    use {'tpope/vim-unimpaired', requires = {'tpope/vim-repeat'}}
    use {'windwp/nvim-autopairs', commit = '97e454c'}
    use {
        'windwp/nvim-ts-autotag',
        commit = '32bc46e',
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    }
    use {'numToStr/Comment.nvim', commit = '90df2f8'}
    use {'JoosepAlviste/nvim-ts-context-commentstring', commit = '097df33'}

    -- Telescope
    use {'nvim-lua/plenary.nvim', commit = '563d9f6'}
    use {'nvim-telescope/telescope.nvim', commit = 'f262e7d'}
    use {'nvim-telescope/telescope-fzy-native.nvim', commit = '7b3d252'}

    -- Git
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use {
        'lewis6991/gitsigns.nvim',
        commit = 'f43cee3',
        config = function()
            require('gitsigns').setup()
        end,
    }
    use {'APZelos/blamer.nvim', commit = 'f4eb22a'}
    use {'sindrets/diffview.nvim', commit = 'eef4745'}

    -- LSP
    use 'neovim/nvim-lspconfig'
    use {'williamboman/nvim-lsp-installer', commit = '5e20d05'}
    use {'jose-elias-alvarez/nvim-lsp-ts-utils', commit = 'fb2f9d8'}

    -- Completion
    use {'hrsh7th/nvim-cmp', commit = '4c0a651'}
    use {'hrsh7th/cmp-nvim-lsp', commit = 'ebdfc20'}
    use {'hrsh7th/cmp-buffer', commit = 'f83773e'}
    use {'hrsh7th/cmp-path', commit = 'c5230cb'}
    use {'hrsh7th/cmp-nvim-lua', commit = 'd276254'}
    use {'onsails/lspkind-nvim', commit = 'f0d1552'}
    use {'saadparwaiz1/cmp_luasnip', commit = 'd6f837f'}

    -- Snippets
    use {'L3MON4D3/LuaSnip', commit = '0222ee6'}
    use {'rafamadriz/friendly-snippets', commit = '35bacce'}

    -- Debugger
    use {'mfussenegger/nvim-dap', commit = 'c9a5826'}
    use {'Pocco81/DAPInstall.nvim', commit = 'dd09e9d'}
    use {'nvim-telescope/telescope-dap.nvim', commit = 'b4134ff'}

    -- File explorer
    use {'kyazdani42/nvim-tree.lua', commit = '0a2f6b0'}

    -- Integrated terminal
    use {'akinsho/toggleterm.nvim', commit = 'f23866b'}

    -- Status line
    use {'nvim-lualine/lualine.nvim', commit = '70691ae'}

    -- Misc
    use {
        'folke/which-key.nvim',
        commit = '28d2bd1',
        config = function()
            require('which-key').setup({ignore_missing = true})
        end,
    }
    use {'psliwka/vim-smoothie', commit = '10fd0aa'}
    use {'norcalli/nvim-colorizer.lua', commit = '36c610a'}
    use {
        'iamcco/markdown-preview.nvim',
        commit = 'e5bfe9b',
        run = 'cd app && yarn install',
        ft = 'markdown',
    }

    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
