call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat', 'do': ':TSUpdate'}

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'glepnir/lspsaga.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'L3MON4D3/LuaSnip'

" Icons
Plug 'kyazdani42/nvim-web-devicons'

" Status line
Plug 'nvim-lualine/lualine.nvim'

call plug#end()

let mapleader = " "

" Source vimrc
nnoremap <leader><cr> :so ~/dotfiles/nvim/.config/nvim/init.vim<cr>

" Netrw
let g:netrw_winsize = 40
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_banner = 0
nnoremap <leader>e :Vex<cr>
