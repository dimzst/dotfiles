require('lsp_lines').setup()

local toggle_lines = function(enabled)
    vim.diagnostic.config({
        virtual_lines = enabled,
        virtual_text = not enabled,
    })
end

local lines_enabled = false
toggle_lines(lines_enabled)

vim.keymap.set('n', '<leader>dl', function()
    lines_enabled = not lines_enabled
    toggle_lines(lines_enabled)
end, { noremap = true })
