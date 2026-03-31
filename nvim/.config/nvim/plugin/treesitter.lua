if IS_VSCODE then
    return
end

-- Install parsers.
require('nvim-treesitter').install({
    'bash',
    'c',
    'comment',
    'css',
    'diff',
    'dockerfile',
    'elm',
    'gitignore',
    'go',
    'gomod',
    'gowork',
    'gosum',
    'hjson',
    'html',
    'java',
    'javascript',
    'jsdoc',
    'json',
    'just',
    'lua',
    'markdown',
    'markdown_inline',
    'rust',
    'scss',
    'sql',
    'svelte',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
})

-- Enable treesitter highlighting (built into Neovim).
vim.api.nvim_create_autocmd('FileType', {
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end,
})

-- Textobjects
require('nvim-treesitter-textobjects').setup({
    select = { lookahead = true },
    move = { set_jumps = true },
})

local map = vim.keymap.set
local select_to = require('nvim-treesitter-textobjects.select').select_textobject
local move = require('nvim-treesitter-textobjects.move')

-- Select
map({ 'x', 'o' }, 'af', function()
    select_to('@function.outer', 'textobjects')
end, { desc = 'Select outer part of a function' })
map({ 'x', 'o' }, 'if', function()
    select_to('@function.inner', 'textobjects')
end, { desc = 'Select inner part of a function' })
map({ 'x', 'o' }, 'ac', function()
    select_to('@class.outer', 'textobjects')
end, { desc = 'Select outer part of a class region' })
map({ 'x', 'o' }, 'ic', function()
    select_to('@class.inner', 'textobjects')
end, { desc = 'Select inner part of a class region' })

-- Move: next
map({ 'n', 'x', 'o' }, ']m', function()
    move.goto_next_start('@function.outer', 'textobjects')
end, { desc = 'Next function start' })
map({ 'n', 'x', 'o' }, ']]', function()
    move.goto_next_start('@class.outer', 'textobjects')
end, { desc = 'Next class start' })
map({ 'n', 'x', 'o' }, ']o', function()
    move.goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects')
end, { desc = 'Next loop section' })
map({ 'n', 'x', 'o' }, ']M', function()
    move.goto_next_end('@function.outer', 'textobjects')
end, { desc = 'Next function end' })
map({ 'n', 'x', 'o' }, '][', function()
    move.goto_next_end('@class.outer', 'textobjects')
end, { desc = 'Next class end' })

-- Move: previous
map({ 'n', 'x', 'o' }, '[m', function()
    move.goto_previous_start('@function.outer', 'textobjects')
end, { desc = 'Previous function start' })
map({ 'n', 'x', 'o' }, '[[', function()
    move.goto_previous_start('@class.outer', 'textobjects')
end, { desc = 'Previous class start' })
map({ 'n', 'x', 'o' }, '[M', function()
    move.goto_previous_end('@function.outer', 'textobjects')
end, { desc = 'Previous function end' })
map({ 'n', 'x', 'o' }, '[]', function()
    move.goto_previous_end('@class.outer', 'textobjects')
end, { desc = 'Previous class end' })

require('nvim-web-devicons').setup({ override = {}, default = true })
