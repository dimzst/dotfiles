-- require("translate").setup({
--     default = {
--         command = "google",
--     },
-- })
-- vim.keymap.set('v', '<leader>tw', function()
--     local first = vim.fn.line('v')
--     local last = vim.fn.line('.')
--     tz.narrow(first, last)
-- end, { noremap = true })

vim.g["translator_target_lang"] = 'en'

vim.keymap.set('v', '<leader>tw', ':TranslateW<CR>', { silent = true })
