vim.loader.enable()

require('mjlaufer.globals')
require('mjlaufer.settings')
require('mjlaufer.keymaps')

-- Build hooks (must be registered before vim.pack.add).
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind

        if kind ~= 'install' and kind ~= 'update' then
            return
        end

        if name == 'nvim-treesitter' then
            if not ev.data.active then
                vim.cmd.packadd('nvim-treesitter')
            end
            vim.cmd('TSUpdate')
        elseif name == 'markdown-preview.nvim' then
            vim.system({ 'sh', '-c', 'cd app && yarn install && git restore .' }, {
                cwd = ev.data.path,
            })
        end
    end,
})

-- Core plugins (always loaded, including VS Code).
vim.pack.add({
    { src = 'https://github.com/echasnovski/mini.ai', version = vim.version.range('*') },
    { src = 'https://github.com/echasnovski/mini.bracketed', version = vim.version.range('*') },
    { src = 'https://github.com/echasnovski/mini.splitjoin', version = vim.version.range('*') },
    { src = 'https://github.com/echasnovski/mini.surround', version = vim.version.range('*') },
    'https://github.com/tpope/vim-characterize',
    'https://github.com/tpope/vim-eunuch',
    'https://github.com/justinmk/vim-gtfo',
    'https://github.com/justinmk/vim-sneak',
}, { load = true })

if not IS_VSCODE then
    vim.pack.add({
        -- Dependency (used by Neotest)
        'https://github.com/nvim-lua/plenary.nvim',

        -- UI
        'https://github.com/mjlaufer/inklight.nvim',
        'https://github.com/folke/snacks.nvim',
        'https://github.com/nvim-treesitter/nvim-treesitter',
        'https://github.com/nvim-treesitter/nvim-treesitter-context',
        'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
        'https://github.com/nvim-tree/nvim-web-devicons',

        -- LSP
        'https://github.com/neovim/nvim-lspconfig',
        'https://github.com/williamboman/mason.nvim',
        'https://github.com/j-hui/fidget.nvim',
        'https://github.com/b0o/schemastore.nvim',
        'https://github.com/folke/lazydev.nvim',
        'https://github.com/mfussenegger/nvim-jdtls',

        -- Workspace
        { src = 'https://github.com/echasnovski/mini.bufremove', version = vim.version.range('*') },
        { src = 'https://github.com/echasnovski/mini.clue', version = vim.version.range('*') },
        'https://github.com/ibhagwan/fzf-lua',
        'https://github.com/nvim-tree/nvim-tree.lua',
        'https://github.com/stevearc/oil.nvim',
        'https://github.com/nvim-lualine/lualine.nvim',

        'https://github.com/MagicDuck/grug-far.nvim',

        -- Editor
        'https://github.com/stevearc/conform.nvim',
        'https://github.com/folke/ts-comments.nvim',
        'https://github.com/windwp/nvim-autopairs',
        'https://github.com/windwp/nvim-ts-autotag',
        'https://github.com/catgoose/nvim-colorizer.lua',

        -- Git
        'https://github.com/lewis6991/gitsigns.nvim',
        'https://github.com/sindrets/diffview.nvim',
        'https://github.com/linrongbin16/gitlinker.nvim',

        -- Debug + Test
        'https://github.com/nvim-neotest/nvim-nio',
        'https://github.com/mfussenegger/nvim-dap',
        'https://github.com/rcarriga/nvim-dap-ui',
        'https://github.com/theHamsta/nvim-dap-virtual-text',
        'https://github.com/nvim-neotest/neotest',
        'https://github.com/antoinemadec/FixCursorHold.nvim',
        'https://github.com/fredrikaverpil/neotest-golang',

        -- Language-specific
        'https://github.com/OXY2DEV/markview.nvim',
        'https://github.com/iamcco/markdown-preview.nvim',
        'https://github.com/olexsmir/gopher.nvim',
    }, { load = true })
end

if IS_VSCODE then
    require('mjlaufer.vscode')
end
