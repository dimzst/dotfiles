require "telescope".setup {
	defaults = {
		file_sorter = require('telescope.sorters').get_fzy_sorter,
		file_ignore_patterns = { "node_modules", "vendor"},
	},
	pickers = {
		buffers = {
			mappings = {
				i = {
					["<c-q>"] =  "delete_buffer"
				},
				n = {
					["<c-q>"] =  "delete_buffer",
				},
			},
		},
	},
}
require('telescope').load_extension('fzy_native')

vim.api.nvim_set_keymap('n', '<c-p>', '<cmd>Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>lua require("telescope.builtin").grep_string({search = vim.fn.input("Search for > ")})<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fw', '<cmd>lua require("telescope.builtin").grep_string({search = vim.fn.expand("<cword>")})<cr>', {noremap = true})
