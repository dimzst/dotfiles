vim.g["goyo_width"] = 120
vim.g["goyo_height"] = 95
vim.g["goyo_linenr"] = 2

function goyo_enter()
    vim.api.nvim_command('FocusDisable')
end

function goyo_leave()
    vim.api.nvim_command('FocusEnable')
end

vim.cmd([[
    autocmd! User GoyoEnter nested lua goyo_enter()
    autocmd! User GoyoLeave nested lua goyo_leave()
]])
