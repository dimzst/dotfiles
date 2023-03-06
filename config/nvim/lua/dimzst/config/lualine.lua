local my_theme = require'lualine.themes.gruvbox-material'

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

local ignoreFT = {
    ['TelescopePrompt'] = true,
}

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

local function modified_file_theme(theme)
    for k,v in pairs(theme) do
        for section, orig in pairs(v) do
            if section == 'c' then
                theme[k][section] = function()
                    if ignoreFT[vim.bo.filetype] then
                        return orig
                    end

                    if vim.bo.modified then
                        return {fg = orig.bg, bg = config.modified_color, gui = 'bold'}
                    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
                        return orig
                    end
                end
            end
        end
    end

    return theme
end

require('lualine').setup({
    options = {
        theme =  modified_file_theme(my_theme),
        section_separators = { left = config.separator.left.section, right = config.separator.right.section },
        component_separators = { left = config.separator.left.component, right = config.separator.right.component},
        extensions = {'fugitive', 'quickfix', 'nvim-tree'},
        always_divide_middle = false,
        globalstatus = true
    },
    sections = {
        lualine_c = {
            {'filename', path = 1},
        },
        lualine_x = {
            {'encoding'},
            {'fileformat'},
            {'filetype', colored = false},
            {lsp_stat},
        },
    },
    -- winbar = {
    --     lualine_c = {'filename'},
    -- },
})
