vim.cmd([[
    let g:blamer_enabled = 1
    let g:blamer_delay = 500
    let g:blamer_date_format = '%m/%d/%y'

    highlight Blamer guifg=#595959

    nnoremap <leader>gb :BlamerToggle<CR>
]]) 

require('gitsigns').setup()
