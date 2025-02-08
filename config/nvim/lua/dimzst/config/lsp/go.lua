local lspconfig = require('lspconfig')
local common = require('dimzst.config.lsp.common')

local go_import = function(timeout_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
end

local go_fmt_import = function(timeout_ms)
    vim.lsp.buf.format({async = false}, timeout_ms)
    go_import(timeout_ms)
end

local go_on_attach = function(next)
    return function(client, bufnr)
        local group = vim.api.nvim_create_augroup("goplsgroup", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function() go_fmt_import(1000) end,
            group = group,
        })

        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', '<leader>oi', function() go_import(1000) end, opts)

        next(client, bufnr)
    end
end

lspconfig.gopls.setup({
    on_attach = go_on_attach(common.on_attach),
    capabilities = common.capabilities,
    flags = {
        debounce_text_changes = 150,
    },
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            experimentalPostfixCompletions = false,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            -- analysisProgressReporting = false,
            staticcheck = true,
            usePlaceholders = true,
            -- Experimental settings
            -- completeUnimported = true,-- autocomplete unimported packages
            -- watchFileChanges = true,  -- watch file changes outside of the editor
            -- deepCompletion = true,    -- enable deep completion
            hints = {
                assignVariableTypes = false,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = false,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            codelenses = {
                gc_details = false,
            --     generate = true,
            --     regenerate_cgo = true,
                tidy = true,
            --     upgrade_dependency = true,
            --     vendor = true,
            --     test = true,
            }
        },
    },
    init_options = {
        usePlaceholders = true,
    }
})

-- Auto attach gopls to new file
local go_newfile_attach = function()
    local result = vim.lsp.get_active_clients()
    -- can't find workaround to start lsp client when buf has not been saved
    if not result or next(result) == nil then return end
    -- use the first client
    vim.lsp.buf_attach_client(0, result[1].id)
end

-- local go_save_attach = function()
--     local ready = vim.lsp.buf.server_ready()
--     if not ready then
--         local result = vim.lsp.get_active_clients()
--         if not result or next(result) == nil then
--             lspconfig.gopls.autostart()
--         else
--             -- use the first client
--             vim.lsp.buf_attach_client(0, result[1].id)
--         end
--     end
-- end

local goplsattach = vim.api.nvim_create_augroup("goplsattach", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.go",
    callback = go_newfile_attach,
    group = goplsattach,
})
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = "*.go",
--     callback = go_save_attach,
--     group = goplsattach,
-- })
