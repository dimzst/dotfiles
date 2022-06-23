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

-- attach custom function to theme section c
for k,v in pairs(custom_theme) do
    for section, orig in pairs(v) do
        if section == 'c' then
            custom_theme[k][section] = function()
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

require('lualine').setup({
    options = {
        theme =  custom_theme,
        section_separators = { left = config.separator.left.section, right = config.separator.right.section },
        component_separators = { left = config.separator.left.component, right = config.separator.right.component},
        extensions = {'fugitive', 'quickfix', 'nvim-tree'},
        always_divide_middle = false,
        globalstatus = true
    },
    sections = {
        lualine_c = {
            {
                'filename',
            },
        },
        lualine_x = {
            {'encoding'},
            {'fileformat'},
            {'filetype', colored = false},
            {lsp_stat},
        },
    }
})
