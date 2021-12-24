call plug#begin('~/.vim/plugged')

" Colors and icons
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat', 'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'

" Editor
Plug 'tpope/vim-surround'
Plug 'windwp/nvim-autopairs'
Plug 'numToStr/Comment.nvim'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'lewis6991/gitsigns.nvim'
Plug 'APZelos/blamer.nvim'
Plug 'sindrets/diffview.nvim'

" LSP and completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'onsails/lspkind-nvim'
Plug 'saadparwaiz1/cmp_luasnip'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'nvim-telescope/telescope-dap.nvim'

" File explorer
Plug 'kyazdani42/nvim-tree.lua'

" Integrated terminal
Plug 'akinsho/toggleterm.nvim'

" Status line
Plug 'nvim-lualine/lualine.nvim'

" Smooth scrolling for C-d and C-u
Plug 'psliwka/vim-smoothie'

" Misc
Plug 'norcalli/nvim-colorizer.lua'

call plug#end()

let mapleader = " "
