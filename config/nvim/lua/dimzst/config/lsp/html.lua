local common = require('dimzst.config.lsp.common')

require('lspconfig').html.setup({
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        provideFormatter = true,
    },
    capabilities = common.capabilities,
})
