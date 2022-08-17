require('fidget').setup()

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '<leader>e', vim.lsp.diagnostic.show_line_diagnostics, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, opts)

require('dimzst.config.lsp.go')
require('dimzst.config.lsp.typescript')
require('dimzst.config.lsp.rust')
require('dimzst.config.lsp.lua')
