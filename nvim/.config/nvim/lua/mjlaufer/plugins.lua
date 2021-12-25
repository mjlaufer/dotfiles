local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    }
    print 'Installing packer close and reopen Neovim...'
    vim.cmd [[packadd packer.nvim]]
end

local status_ok, packer = pcall(require, 'packer')
if not status_ok then return end

return packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Colors and icons
    use 'gruvbox-community/gruvbox'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'kyazdani42/nvim-web-devicons'

    -- Editor
    use 'tpope/vim-surround'
    use 'windwp/nvim-autopairs'
    use 'numToStr/Comment.nvim'
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- Telescope
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- Git
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'lewis6991/gitsigns.nvim'
    use 'APZelos/blamer.nvim'
    use 'sindrets/diffview.nvim'

    -- LSP and completion
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'onsails/lspkind-nvim'
    use 'saadparwaiz1/cmp_luasnip'

    -- Snippets
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'

    -- Debugger
    use 'mfussenegger/nvim-dap'
    use 'Pocco81/DAPInstall.nvim'
    use 'nvim-telescope/telescope-dap.nvim'

    -- File explorer
    use 'kyazdani42/nvim-tree.lua'

    -- Integrated terminal
    use 'akinsho/toggleterm.nvim'

    -- Status line
    use 'nvim-lualine/lualine.nvim'

    -- Smooth scrolling
    use 'psliwka/vim-smoothie'

    -- Misc
    use 'norcalli/nvim-colorizer.lua'
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        ft = 'markdown'
    }

    if PACKER_BOOTSTRAP then require('packer').sync() end
end)
