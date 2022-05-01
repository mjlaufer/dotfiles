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

    -- Colors
    use {'nvim-treesitter/nvim-treesitter', commit = '6f6cb20', run = ':TSUpdate'}
    use {'nvim-treesitter/playground', commit = '13e2d2d'}
    use 'mjlaufer/undercity.nvim'

    -- Icons (used by lualine and nvim-tree)
    use {
        'kyazdani42/nvim-web-devicons',
        commit = '2033e8e',
        config = function()
            require('nvim-web-devicons').setup({override = {}, default = true})
        end,
    }

    -- Editor
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-surround'
    use {'tpope/vim-unimpaired', requires = {'tpope/vim-repeat'}}
    use {'windwp/nvim-autopairs', commit = '63779ea'}
    use {
        'windwp/nvim-ts-autotag',
        commit = '32bc46e',
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    }
    use {'numToStr/Comment.nvim', commit = 'cb0de89'}
    use {'JoosepAlviste/nvim-ts-context-commentstring', commit = '8834375'}

    -- Telescope
    use {'nvim-lua/plenary.nvim', commit = '9069d14'}
    use {'nvim-telescope/telescope.nvim', commit = '57bd8a5'}

    -- Git
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use {
        'lewis6991/gitsigns.nvim',
        commit = 'b800663',
        config = function()
            require('gitsigns').setup()
        end,
    }
    use {'APZelos/blamer.nvim', commit = 'f4eb22a'}
    use {'sindrets/diffview.nvim', commit = '2d1f452'}

    -- LSP
    use 'neovim/nvim-lspconfig'
    use {'williamboman/nvim-lsp-installer', commit = 'cd4dac0'}
    use {'jose-elias-alvarez/nvim-lsp-ts-utils', commit = '1826275'}

    -- Completion
    use {'hrsh7th/nvim-cmp', commit = 'f841fa6'}
    use {'hrsh7th/cmp-nvim-lsp', commit = 'ebdfc20'}
    use {'hrsh7th/cmp-buffer', commit = 'd66c4c2'}
    use {'hrsh7th/cmp-path', commit = '466b6b8'}
    use {'hrsh7th/cmp-nvim-lua', commit = 'd276254'}
    use {'onsails/lspkind-nvim', commit = '57e5b5d'}

    -- Snippets
    use {'saadparwaiz1/cmp_luasnip', commit = 'b108297'}
    use {'L3MON4D3/LuaSnip', commit = '7fc4f14'}
    use {'rafamadriz/friendly-snippets', commit = '6e0881a'}

    -- Debugger
    use {'mfussenegger/nvim-dap', commit = 'd6d8317'}
    use {'nvim-telescope/telescope-dap.nvim', commit = 'b4134ff'}
    use {'theHamsta/nvim-dap-virtual-text', commit = '10368a1'}
    use {'rcarriga/nvim-dap-ui', commit = '3eec525'}

    -- File explorer
    use {'kyazdani42/nvim-tree.lua', commit = '86d573d'}

    -- Integrated terminal
    use {'akinsho/toggleterm.nvim', commit = '6c7f5db'}

    -- Status line
    use {'nvim-lualine/lualine.nvim', commit = '030eb62'}

    -- Misc
    use {
        'folke/which-key.nvim',
        commit = 'a3c19ec',
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
