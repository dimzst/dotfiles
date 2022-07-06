local common = require('dimzst.config.lsp.common')

require('rust-tools').setup({
    server = {
        on_attach = common.on_attach,
        capabilities = common.capabilities,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
})
