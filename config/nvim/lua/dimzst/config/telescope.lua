require "telescope".setup {
	defaults = {
		file_ignore_patterns = { "node_modules", "vendor", "^.git/" },
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
	extensions = {
		fzf = {
			fuzzy = true,
			-- override_generic_sorter = true,
			-- override_file_sorter = true,
			case_mode = "smart_case",
		}
	}
}
require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap('n', '<c-p>', '<cmd>Telescope find_files hidden=true<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>lua require("telescope.builtin").grep_string({search = vim.fn.input("Search for > ")})<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fw', '<cmd>lua require("telescope.builtin").grep_string({search = vim.fn.expand("<cword>")})<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fq', '<cmd>lua require("telescope.builtin").quickfix(require("telescope.themes").get_ivy({}))<cr>', {noremap = true})
