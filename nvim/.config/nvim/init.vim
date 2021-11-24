" Keep edited buffers around in the background.
set hidden

set noerrorbells

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set relativenumber
set nu
set signcolumn=yes
set colorcolumn=100
set scrolloff=8

" History
set noswapfile
set nobackup

" Remove highlight from search term when search is complete.
set nohlsearch
set incsearch

" Enable True Color support.
set termguicolors

" Plug
call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'neovim/nvim-lspconfig'
call plug#end()

let g:gruvbox_bold = 0
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

let mapleader = " "

" Source vimrc
nnoremap <leader><cr> :so ~/dotfiles/nvim/.config/nvim/init.vim<cr>

" Netrw maps
let g:netrw_winsize = 40
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_banner = 0
nnoremap <leader>e :Vex<cr> 

" Telescope maps
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>
nnoremap <leader>fs :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<cr>
nnoremap <leader>fsl <cmd>Telescope live_grep<cr>
nnoremap <leader>fbf <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
