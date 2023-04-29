vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
        [".*"] = {
            cmdline  = "neovim",
            content  = "text",
            priority = 0,
            selector = "textarea",
            takeover = "never"
        }
    }
}

if vim.g.started_by_firenvim == true then
    local group = vim.api.nvim_create_augroup("FireNvimFT", { clear = true })
    vim.api.nvim_create_autocmd({"BufEnter"}, {
        pattern = "*.txt",
        command = "set filetype=markdown",
        group = group,
    })
    vim.api.nvim_create_autocmd({"BufEnter"}, {
        pattern = "go.dev_play_*.txt",
        command = "set filetype=go | call GuiFont(22)",
        group = group,
    })
end
