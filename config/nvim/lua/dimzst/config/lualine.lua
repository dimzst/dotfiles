-- local custom_theme = require'dimzst.lualine.themes.edge'
local custom_theme = require'lualine.themes.catppuccino'
custom_theme.normal.x = custom_theme.normal.c

local diag_hi_init = false

local config = {
	modified_color = '#deb974',
	separator = {
		left = {
			section = '',
			component = ''
		},
		right = {
			section = '',
			component = ''
		}
	}
}

local function get_hi_value(bg, fg, gui)
	local data = 'guibg=' .. bg .. ' guifg=' ..  fg
	if gui ~= nil and gui ~= '' then
		data = data .. ' gui=' .. gui
	end
	return data
end

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

local function diagnostic_count() 
	local error_count = vim.lsp.diagnostic.get_count(0, 'Error')
	local warning_count = vim.lsp.diagnostic.get_count(0, 'Warning')
	local info_count = vim.lsp.diagnostic.get_count(0, 'Information')
	return error_count + warning_count + info_count
end



local function diag_left_sep()
	local data = '%='

	local count = diagnostic_count()
	if count == 0 then
		return data
	end

	if diag_hi_init == false then
		local highlight = get_hi_value(config.modified_color, custom_theme.normal.c.bg)
		vim.api.nvim_command(
			'hi! lualine_diag_left_sep ' .. highlight)
		diag_hi_init = true
	end

	if vim.bo.modified then
		return '%#lualine_diag_left_sep#' .. config.separator.left.section .. data
	end
	return config.separator.left.component .. data
end

local function file_right_sep()
	local c_hi = get_hi_value(custom_theme.normal.c.bg, custom_theme.normal.c.fg, 'NONE')
	local btoc_hi = get_hi_value(custom_theme.normal.c.bg, custom_theme.normal.b.bg)
	local ctox_hi = get_hi_value(custom_theme.normal.c.bg, custom_theme.normal.c.bg)
	local antoc_hi = get_hi_value(custom_theme.normal.c.bg, custom_theme.normal.a.bg)
	local actoc_hi = get_hi_value(custom_theme.normal.c.bg, custom_theme.command.a.bg)
	local avtoc_hi = get_hi_value(custom_theme.normal.c.bg, custom_theme.visual.a.bg)
	local aitoc_hi = get_hi_value(custom_theme.normal.c.bg, custom_theme.insert.a.bg)

	if vim.bo.modified then
		c_hi = get_hi_value(config.modified_color, custom_theme.normal.a.fg, 'bold')
		btoc_hi = get_hi_value(config.modified_color, custom_theme.normal.b.bg)
		ctox_hi = get_hi_value(config.modified_color, custom_theme.normal.c.bg)
		antoc_hi = get_hi_value(config.modified_color, custom_theme.normal.a.bg)
		actoc_hi = get_hi_value(config.modified_color, custom_theme.command.a.bg)
		avtoc_hi = get_hi_value(config.modified_color, custom_theme.visual.a.bg)
		aitoc_hi = get_hi_value(config.modified_color, custom_theme.insert.a.bg)
	end

	vim.api.nvim_command(
        'hi! lualine_c_normal ' .. c_hi)
	vim.api.nvim_command(
        'hi! lualine_c_insert ' .. c_hi)
	vim.api.nvim_command(
        'hi! lualine_c_visual ' .. c_hi)
	vim.api.nvim_command(
        'hi! lualine_c_command ' .. c_hi)
	
	vim.api.nvim_command(
        'hi! lualine_a_normal_to_lualine_c_normal ' .. antoc_hi)
	vim.api.nvim_command(
        'hi! lualine_a_insert_to_lualine_c_insert ' .. aitoc_hi)
	vim.api.nvim_command(
        'hi! lualine_a_insert_to_lualine_c_normal ' .. aitoc_hi)
	vim.api.nvim_command(
        'hi! lualine_a_command_to_lualine_c_command ' .. actoc_hi)
	vim.api.nvim_command(
        'hi! lualine_a_command_to_lualine_c_normal ' .. actoc_hi)
	vim.api.nvim_command(
        'hi! lualine_a_visual_to_lualine_c_visual ' .. avtoc_hi)
	vim.api.nvim_command(
        'hi! lualine_a_visual_to_lualine_c_normal ' .. avtoc_hi)

	vim.api.nvim_command(
        'hi! lualine_b_normal_to_lualine_c_normal ' .. btoc_hi)
	vim.api.nvim_command(
        'hi! lualine_b_insert_to_lualine_c_insert ' .. btoc_hi)
	vim.api.nvim_command(
        'hi! lualine_b_insert_to_lualine_c_normal ' .. btoc_hi)
	vim.api.nvim_command(
        'hi! lualine_b_normal_to_lualine_c_command ' .. btoc_hi)
	vim.api.nvim_command(
        'hi! lualine_b_command_to_lualine_c_normal ' .. btoc_hi)
	vim.api.nvim_command(
        'hi! lualine_b_command_to_lualine_c_command ' .. btoc_hi)
	vim.api.nvim_command(
        'hi! lualine_b_visual_to_lualine_c_visual ' .. btoc_hi)
	vim.api.nvim_command(
        'hi! lualine_b_visual_to_lualine_c_normal ' .. btoc_hi)

	vim.api.nvim_command(
        'hi! lualine_c_normal_to_lualine_x_normal ' .. ctox_hi)

	if vim.bo.modified then
		return '%#lualine_c_normal_to_lualine_x_normal#' .. 
			config.separator.right.section .. '%'
	end
	return config.separator.right.component
end

require('lualine').setup {
	options = {
		theme =  'catppuccino',
		section_separators = {config.separator.left.section, config.separator.right.section },
		component_separators = {config.separator.left.component, config.separator.right.component},
		-- component_separators = {'|', '|'},
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
				separator = '',
			},
			{diag_left_sep, separator = '', left_padding=0},
			{'filename', path = 1, separator = ''},
		},
		lualine_x = {
			{file_right_sep, separator = ''},
			{'encoding'},
			{'fileformat'},
			{'filetype'},
			{lsp_stat},
		},
	}
}
