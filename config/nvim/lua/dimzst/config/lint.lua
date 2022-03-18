local golint = require('lint').linters.golangcilint
golint.stdin = true
golint.append_fname = false

require('lint').linters_by_ft = {
  go = {'golangcilint'}
}

vim.cmd([[
augroup linter
autocmd!
autocmd BufReadPost,FileReadPost * lua require('lint').try_lint()
autocmd BufWritePost * lua require('lint').try_lint()
augroup END
]])

-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
