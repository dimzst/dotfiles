local common = require('dimzst.config.lsp.common')

require('lspconfig').tsserver.setup({
    on_attach = common.on_attach,
    capabilities = common.capabilities,
})
