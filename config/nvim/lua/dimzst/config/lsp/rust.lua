local common = require('dimzst.config.lsp.common')

local rust_opts = {
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
}

require('rust-tools').setup(rust_opts)
