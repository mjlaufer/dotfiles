lua << EOF
require('telescope').setup {
    defaults = {
        file_ignore_patterns = { "node_modules" }
    }
}

require('telescope').load_extension('dap')
EOF

nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope git_files<CR>
nnoremap <leader>fb <cmd>Telescope file_browser<CR>
nnoremap <leader>fs :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")})<CR>
nnoremap <leader>fsl <cmd>Telescope live_grep<CR>
nnoremap <leader>fbf <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>

" Telescope DAP
nnoremap <leader>dtb <cmd>Telescope dap list_breakpoints<CR>
nnoremap <leader>dtf <cmd>Telescope dap frames<CR>
nnoremap <leader>dtv <cmd>Telescope dap variables<CR>
