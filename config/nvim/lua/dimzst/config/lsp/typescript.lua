local common = require('dimzst.config.lsp.common')

local ts_on_attach = function(next)
    return function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', '<leader>oi', function()
            vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})
        end, opts)

        next(client, bufnr)
    end
end

require('lspconfig').tsserver.setup({
    on_attach = ts_on_attach(common.on_attach),
    capabilities = common.capabilities,
})
