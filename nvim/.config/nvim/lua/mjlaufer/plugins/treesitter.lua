require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'bash',
        'c',
        'comment',
        'css',
        'diff',
        'dockerfile',
        'elm',
        'gitignore',
        'go',
        'hjson',
        'html',
        'java',
        'javascript',
        'jsdoc',
        'json',
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
    },
    highlight = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj.
            keymaps = {
                ['af'] = { query = '@function.outer', desc = 'Select outer part of a function' },
                ['if'] = { query = '@function.inner', desc = 'Select inner part of a function' },
                ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class region' },
                ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- Set jumps in the jumplist.
            goto_next_start = {
                [']m'] = { query = '@function.outer', desc = 'Next function start' },
                [']]'] = { query = '@class.outer', desc = 'Next class start' },
                [']o'] = { query = { '@loop.inner', '@loop.outer' }, desc = 'Next loop section' },
            },
            goto_next_end = {
                [']M'] = { query = '@function.outer', desc = 'Next function end' },
                [']['] = { query = '@class.outer', desc = 'Next class end' },
            },
            goto_previous_start = {
                ['[m'] = { query = '@function.outer', desc = 'Previous function start' },
                ['[['] = { query = '@class.outer', desc = 'Previous class start' },
            },
            goto_previous_end = {
                ['[M'] = { query = '@function.outer', desc = 'Previous function end' },
                ['[]'] = { query = '@class.outer', desc = 'Previous class end' },
            },
        },
    },
})
