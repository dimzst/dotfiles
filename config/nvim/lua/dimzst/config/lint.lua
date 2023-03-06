local golint = require('lint').linters.golangcilint
golint.stdin = true
golint.append_fname = false

require('lint').linters_by_ft = {
    go = {'golangcilint'}
}

local linter_group = vim.api.nvim_create_augroup("linter", { clear = true })
vim.api.nvim_create_autocmd({"BufWritePost", "BufReadPost", "FileReadPost"}, {
    pattern = "*",
    command = "lua require('lint').try_lint()",
    group = linter_group,
})
