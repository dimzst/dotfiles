vim.g["goyo_width"] = 120
vim.g["goyo_height"] = 95
vim.g["goyo_linenr"] = 2

local group = vim.api.nvim_create_augroup("GoyoGroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
    pattern = "GoyoEnter",
    callback = function()
        vim.api.nvim_command('FocusDisable')
    end,
    group = group,
    nested = true,
})
vim.api.nvim_create_autocmd("User", {
    pattern = "GoyoLeave",
    callback = function()
        vim.api.nvim_command('FocusEnable')
    end,
    group = group,
    nested = true,
})
