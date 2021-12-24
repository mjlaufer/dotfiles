vim.cmd([[
let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_date_format = '%m/%d/%y'

" Color for git blamer text
highlight Blamer guifg=#595959

nnoremap <leader>gb :BlamerToggle<CR>
]])

require('gitsigns').setup()

require('diffview').setup({use_icons = true})

vim.cmd([[
nnoremap <leader>gd :DiffviewOpen<CR>
nnoremap <leader>gdc :DiffviewClose<CR>
]])
