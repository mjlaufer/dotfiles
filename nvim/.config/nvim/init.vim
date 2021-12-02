call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-dispatch'
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat', 'do': ':TSUpdate'}

" Bracket pairing
Plug 'jiangmiao/auto-pairs'

" Terminal
Plug 'akinsho/toggleterm.nvim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" LSP and completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'glepnir/lspsaga.nvim'
Plug 'onsails/lspkind-nvim'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'saadparwaiz1/cmp_luasnip'

" Icons
Plug 'kyazdani42/nvim-web-devicons'

" Status line
Plug 'nvim-lualine/lualine.nvim'

call plug#end()

let mapleader = " "

" Source vimrc
nnoremap <leader><cr> :so ~/dotfiles/nvim/.config/nvim/init.vim<CR>

" Git diff (Fugitive)
nnoremap <leader>gd :Gvdiffsplit<CR>

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
let g:netrw_browse_split = 4

augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * :Lex!
augroup END

nnoremap <leader>e :Lex!<CR>
