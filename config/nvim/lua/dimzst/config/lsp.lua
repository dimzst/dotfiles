local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
    buf_set_keymap('n', '<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', "<cmd>lua require'telescope.builtin'.lsp_code_actions(require('telescope.themes').get_cursor({}))<CR>", opts)
    buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap("n", "<leader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
}
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lspconfig.tsserver.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

local go_on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.cmd([[
    augroup goplsgroup
    autocmd!
    autocmd BufWritePre *.go lua gofmtimports({}, 1000)
    augroup END
    ]])

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap("n", "<leader>oi", "<cmd>lua goimports({}, 1000)<CR>", opts)
end

function gofmtimports(timeoutms)
    vim.lsp.buf.formatting_sync(nil, timeout_ms)
    goimports(timeout_ms)
end

function goimports(timeoutms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" }}

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil or result[1] == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
        if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit)
        end
        if type(action.command) == "table" then
            vim.lsp.buf.execute_command(action.command)
        end
    else
        vim.lsp.buf.execute_command(action)
    end
end

function gonewfileattach(timeoutms)
    local result = vim.lsp.get_active_clients()
    -- can't find workaround to start lsp client when buf has not been saved
    if not result or next(result) == nil then return end
    -- use the first client
    vim.lsp.buf_attach_client(0, result[1].id)
end

function gosaveattach(timeoutms)
    local ready = vim.lsp.buf.server_ready()
    if not ready then
        local result = vim.lsp.get_active_clients()
        if not result or next(result) == nil then
            require'lspconfig'.gopls.autostart()
        else
            -- use the first client
            vim.lsp.buf_attach_client(0, result[1].id)
        end
    end
end

lspconfig.gopls.setup{
    on_attach = go_on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            usePlaceholders = true,
        },
    },
    init_options = {
        usePlaceholders = true,
    }
}

vim.cmd([[
augroup goplsattach
autocmd!
autocmd BufNewFile *.go lua gonewfileattach({}, 1000)
autocmd BufWritePost *.go lua gosaveattach({}, 1000)
augroup END
]])

local rust_opts = {
    server = {
        on_attach = on_attach,
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
