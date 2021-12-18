require('telescope').setup {
    defaults = {
        file_ignore_patterns = { 'node_modules', '.git' }
    }
}

require('telescope').load_extension('dap')

vim.cmd([[
    nnoremap <leader>ff <cmd>Telescope find_files<CR>
    nnoremap <leader>fg <cmd>Telescope git_files<CR>
    nnoremap <leader>fs <cmd>Telescope live_grep<CR>
    nnoremap <leader>fw :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")})<CR>
    nnoremap <leader>fb <cmd>Telescope buffers<CR>
    nnoremap <leader>fe <cmd>Telescope file_browser<CR>
    nnoremap <leader>fh <cmd>Telescope help_tags<CR>

    " Telescope DAP
    nnoremap <leader>dtb <cmd>Telescope dap list_breakpoints<CR>
    nnoremap <leader>dtf <cmd>Telescope dap frames<CR>
    nnoremap <leader>dtv <cmd>Telescope dap variables<CR>
]])
