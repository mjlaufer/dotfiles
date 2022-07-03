local util = require('mjlaufer.util')

local opts = {noremap = true, silent = true}

util.map('n', 'f', '<Plug>Sneak_f', opts)
util.map('n', 'F', '<Plug>Sneak_F', opts)
util.map('x', 'f', '<Plug>Sneak_f', opts)
util.map('x', 'F', '<Plug>Sneak_F', opts)
util.map('n', 't', '<Plug>Sneak_t', opts)
util.map('n', 'T', '<Plug>Sneak_T', opts)
util.map('x', 't', '<Plug>Sneak_t', opts)
util.map('x', 'T', '<Plug>Sneak_T', opts)
