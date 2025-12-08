local map = vim.keymap.set

-- Set <space> to no-op since we use it for our leader.
map('', '<Space>', '<Nop>')

-- Remove search highlights.
map('n', '<esc>', ':nohlsearch<CR>', { silent = true, desc = 'Remove search highlights' })

-- Location list diagnostics
map('n', '<leader>ld', vim.diagnostic.setloclist, { desc = 'Show diagnostics' })

-- Improve split navigation (See `:help wincmd`).
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Better movement for wrapped lines
map('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true })
map('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true })

-- Move selected lines up/down.
map('x', 'J', ":m '>+1<CR>gv=gv")
map('x', 'K', ":m '<-2<CR>gv=gv")

-- Stay in indent mode.
map('x', '<', '<gv')
map('x', '>', '>gv')

-- Put yanked/deleted content over selection; keep content in unnamed register.
map('x', '<leader>p', '"_dP')

-- Search in current selection.
map('x', '/', '<esc>/\\%V')

-- Search for current selection.
map('x', '*', ':lua VSetSearch("/")<CR>/<C-r>=@/<CR><CR>')
map('x', '#', ':lua VSetSearch("?")<CR>?<C-r>=@/<CR><CR>')

function _G.VSetSearch(search_cmd)
    vim.cmd([[
        let temp = @s
        norm! gv"sy
    ]])
    if search_cmd == '/' then
        vim.cmd([[ let @/ = '\V' . substitute(escape(@s, '/' . '\'), '\n', '\\n', 'g') ]])
    elseif search_cmd == '?' then
        vim.cmd([[ let @/ = '\V' . substitute(escape(@s, '?' . '\'), '\n', '\\n', 'g') ]])
    end
    vim.cmd([[ let @s = temp ]])
end

-- Substitute word under cursor.
map(
    'n',
    '<leader>r',
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'Replace word under cursor' }
)

-- Always use the same flags when repeating a substitution command.
map('n', '&', ':&&<CR>')
map('x', '&', ':&&<CR>')

-- tmux-sessionizer
map('n', '<c-s>', ':silent !tmux neww tmux-sessionizer<CR>', { silent = true })

-- EMBEDDED TERMINAL EMULATOR
-- `<leader>gl` opens Lazygit in a floating terminal buffer.
-- `<C-\>` opens a terminal buffer in a split (horizontal by default).
-- `<leader>T` toggles the terminal split layout between horizontal and vertical (right side).

-- Open Lazygit in a floating terminal.
vim.keymap.set('n', '<leader>gl', function()
    local buf = vim.api.nvim_create_buf(false, true)
    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(vim.o.lines * 0.9)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        style = 'minimal',
        border = 'rounded',
    })

    -- Use `Normal` instead of `NormalFloat` highlights.
    vim.wo[win].winhl = 'Normal:Normal,NormalFloat:Normal'

    vim.fn.termopen('lazygit', {
        on_exit = function()
            vim.api.nvim_win_close(win, true)
            vim.api.nvim_buf_delete(buf, { force = true })
        end,
    })
    vim.cmd('startinsert')
end)

local term_buf = nil
local term_win = nil
local term_layout = 'horizontal' -- 'horizontal' or 'vertical'

-- Toggle terminal in a split.
vim.keymap.set('n', '<C-\\>', function()
    -- If terminal window is open, close it.
    if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_win_close(term_win, true)
        term_win = nil
        return
    end

    -- If buffer exists and is valid, reuse it.
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
        if term_layout == 'horizontal' then
            vim.cmd('belowright split')
            vim.cmd('resize 20')
        else
            vim.cmd('botright vsplit')
            vim.cmd('vertical resize 80')
        end
        term_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(term_win, term_buf)
        vim.cmd('startinsert')
        return
    end

    -- Create a new terminal.
    if term_layout == 'horizontal' then
        vim.cmd('belowright split | terminal')
        vim.cmd('resize 20')
    else
        vim.cmd('botright vsplit | terminal')
        vim.cmd('vertical resize 80')
    end

    term_win = vim.api.nvim_get_current_win()
    term_buf = vim.api.nvim_get_current_buf()

    vim.keymap.set('t', '<C-\\>', function()
        vim.api.nvim_win_close(term_win, true)
        term_win = nil
    end, { buffer = term_buf })

    -- Clean up when terminal process exits.
    vim.api.nvim_create_autocmd('TermClose', {
        buffer = term_buf,
        callback = function()
            if term_win and vim.api.nvim_win_is_valid(term_win) then
                vim.api.nvim_win_close(term_win, true)
            end
            term_buf = nil
            term_win = nil
        end,
    })

    vim.cmd('startinsert')
end)

-- Toggle terminal split layout orientation.
vim.keymap.set({ 'n', 't' }, '<leader>T', function()
    term_layout = term_layout == 'horizontal' and 'vertical' or 'horizontal'

    -- If terminal is currently open, reopen it in new layout.
    if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_win_close(term_win, true)
        term_win = nil

        -- Reopen with new layout.
        vim.schedule(function()
            if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
                return
            end

            if term_layout == 'horizontal' then
                vim.cmd('belowright split')
                vim.cmd('resize 20')
            else
                vim.cmd('botright vsplit')
                vim.cmd('vertical resize 80')
            end

            term_win = vim.api.nvim_get_current_win()
            vim.api.nvim_win_set_buf(term_win, term_buf)
            vim.cmd('startinsert')
        end)
    end

    print('Terminal layout: ' .. term_layout)
end, { desc = 'Toggle terminal layout' })
