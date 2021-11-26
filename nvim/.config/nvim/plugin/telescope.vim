" Telescope maps
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>
nnoremap <leader>fs :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<cr>
nnoremap <leader>fsl <cmd>Telescope live_grep<cr>
nnoremap <leader>fbf <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
