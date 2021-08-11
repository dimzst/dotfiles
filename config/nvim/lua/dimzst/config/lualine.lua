local custom_theme = require'dimzst.lualine.themes.edge'

local function lsp_stat()
	local msg = ''
	local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then return msg end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return client.name
		end
	end
	return msg
end

require('lualine').setup {
	options = {
		theme =  custom_theme,
		section_separators = {' ', ' ' },
		component_separators = {' ', ' '},
		extensions = {'fugitive'},
	},
	sections = {
		lualine_c = {
			{
				'diagnostics',
				sources = {'nvim_lsp'},
				sections = {'error', 'warn', 'info'},
				color_warn = '#deb974',
				symbols = {error = ' ', warn = ' ', info = ' '},
			},
			{'filename', path = 1},
		},
		lualine_x = {
			{'encoding'},
			{'fileformat'},
			{'filetype'},
			{lsp_stat},
		},
	}
}
