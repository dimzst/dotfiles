require('telescope').setup({
    defaults = {
        file_ignore_patterns = { "node_modules", "vendor", ".git/" },
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
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('neoclip')

local builtin = require('telescope.builtin')
local opts = { noremap=true }

vim.keymap.set('n', '<c-p>', function()
    builtin.find_files({ hidden = true })
end, opts)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Search for > ") })
end, opts)
vim.keymap.set('n', '<leader>fw', function()
    builtin.grep_string({ search = vim.fn.expand("<cword>") })
end, opts)
vim.keymap.set('n', '<leader>fq', function()
    builtin.quickfix(require("telescope.themes").get_ivy({}))
end, opts)
vim.keymap.set('n', '<leader>nc', function()
    require('telescope').extensions.neoclip['star']()
end, opts)
vim.keymap.set('n', '<leader>ny', function()
    require('telescope').extensions.neoclip.default()
end, opts)
