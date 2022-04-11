local custom_theme = require'lualine.themes.gruvbox-material'

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
    },
    shorting_target = 40,
    symbols = {
        modified = '[+]',
        readonly = '[-]',
    }
}

local function count(base, pattern)
    return select(2, string.gsub(base, pattern, ''))
end

local function shorten_path(path, sep)
    return path:gsub(string.format('([^%s])[^%s]+%%%s', sep, sep, sep), '%1' .. sep, 1)
end

local function get_hi_value(bg, fg, gui)
    local data = 'guibg=' .. bg .. ' guifg=' ..  fg
    if gui ~= nil and gui ~= '' then
        data = data .. ' gui=' .. gui
    end
    return data
end

local function cust_file_name()
    local data = vim.fn.expand '%:~:.'
    if data == '' then
        data = '[No Name]'
    end

    local windwidth = vim.fn.winwidth(0)
    local estimated_space_available = windwidth - config.shorting_target

    local path_separator = package.config:sub(1, 1)
    for _ = 0, count(data, path_separator) do
        if windwidth <= 84 or #data > estimated_space_available then
            data = shorten_path(data, path_separator)
        end
    end

    local hi_val = get_hi_value(custom_theme.normal.c.bg, custom_theme.normal.c.fg, 'NONE')

    if vim.bo.modified then
        data = data .. config.symbols.modified
        hi_val = get_hi_value(custom_theme.normal.c.bg, config.modified_color, 'bold')
    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        data = data .. config.symbols.readonly
    end

    vim.api.nvim_command(
    'hi! lualine_cust_file_name_hi ' .. hi_val)

    return '%=' .. '%#lualine_cust_file_name_hi#' .. data
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

require('lualine').setup {
    options = {
        theme =  custom_theme,
        section_separators = { left = config.separator.left.section, right = config.separator.right.section },
        component_separators = { left = config.separator.left.component, right = config.separator.right.component},
        extensions = {'fugitive', 'quickfix', 'nvim-tree'},
    },
    sections = {
        lualine_c = {
            {cust_file_name, separator = '', left_padding=0},
        },
        lualine_x = {
            {'encoding'},
            {'fileformat'},
            {'filetype'},
            {lsp_stat},
        },
    }
}
