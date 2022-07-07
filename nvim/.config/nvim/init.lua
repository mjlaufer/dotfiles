-- Set up `impatient` before any other lua plugin.
require('impatient')

-- Global functions and settings
require('mjlaufer.globals')
require('mjlaufer.options')
require('mjlaufer.keymaps')
require('mjlaufer.plugins')

-- Look and feel
require('mjlaufer.colors')
require('mjlaufer.colorizer')

-- Editor
require('mjlaufer.editorconfig')
require('mjlaufer.autopairs')
require('mjlaufer.comment')
require('mjlaufer.sneak')

-- Workspace
require('mjlaufer.telescope')
require('mjlaufer.trouble')
require('mjlaufer.nvim_tree')
require('mjlaufer.lualine')
require('mjlaufer.terminal')

-- Git
require('mjlaufer.git_plugins')

-- LSP
require('mjlaufer.lsp')

-- Completion
require('mjlaufer.cmp')

-- Debugger
require('mjlaufer.dap')
