local common = require('dimzst.config.lsp.common')

require('lspconfig').pylsp.setup({
    on_attach = common.on_attach,
    capabilities = common.capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    maxLineLength = 100
                },
                jedi_completion = {
                    include_params = true,
                },
            }
        }
    },
})

-- require('lspconfig').pyright.setup({
--     on_attach = common.on_attach,
--     capabilities = common.capabilities,
--     -- settings = {
--     --     python = {
--     --         analysis = {
--     --             typeCheckingMode = "off", -- off, basic, strict
--     --             autoSearchPaths = true,
--     --             useLibraryCodeForTypes = true,
--     --             autoImportCompletions = true,
--     --             diagnosticMode = "workspace",
--     --             -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md#type-check-diagnostics-settings
--     --             diagnosticSeverityOverrides = {
--     --                 strictListInference = true,
--     --                 strictDictionaryInference = true,
--     --                 strictSetInference = true,
--     --                 reportUnusedImport = "warning",
--     --                 reportUnusedClass = "warning",
--     --                 reportUnusedFunction = "warning",
--     --                 reportUnusedVariable = "warning",
--     --                 reportUnusedCoroutine = "warning",
--     --                 reportDuplicateImport = "warning",
--     --                 reportPrivateUsage = "warning",
--     --                 reportUnusedExpression = "warning",
--     --                 reportConstantRedefinition = "error",
--     --                 reportIncompatibleMethodOverride = "error",
--     --                 reportMissingImports = "error",
--     --                 reportUndefinedVariable = "error",
--     --                 reportAssertAlwaysTrue = "error",
--     --             },
--     --         },
--     --     },
--     -- },
-- })
