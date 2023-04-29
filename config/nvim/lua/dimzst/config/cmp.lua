local luasnip = require('luasnip')
local cmp = require('cmp')
local lsp_types = require('cmp.types').lsp

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local exact_kind = function(entry1, entry2)
    if entry1.exact ~= entry2.exact then
        return entry1.exact
    end

    if entry1.exact and entry2.exact then
        local kind1 = entry1:get_kind()
        local kind2 = entry2:get_kind()

        if kind1 ~= kind2 then
            if kind1 == lsp_types.CompletionItemKind.Snippet then
                return true
            end
            if kind2 == lsp_types.CompletionItemKind.Snippet then
                return false
            end
        end
    end
end

local lspkind_comparator = function(conf)
    return function(entry1, entry2)
        local kind1 = entry1:get_kind()
        local kind2 = entry2:get_kind()

        if entry1.source.name ~= 'nvim_lsp' then
            if entry2.source.name == 'nvim_lsp' then
                return false
            else
                return nil
            end
        end

        local lsp_kind1 = lsp_types.CompletionItemKind[kind1]
        local lsp_kind2 = lsp_types.CompletionItemKind[kind2]

        local priority1 = conf.kind_priority[lsp_kind1] or 0
        local priority2 = conf.kind_priority[lsp_kind2] or 0
        if priority1 == priority2 then
            return nil
        end

        return priority1 > priority2
    end
end

local label_comparator = function(entry1, entry2)
    return entry1.completion_item.label < entry2.completion_item.label
end


cmp.setup({
    preselect = cmp.PreselectMode.None,
    sorting = {
        -- comparators = {
        --     exact_kind,
        --     lspkind_comparator({
        --         kind_priority = {
        --             Field = 11,
        --             Property = 11,
        --             Constant = 10,
        --             Enum = 10,
        --             EnumMember = 10,
        --             Event = 10,
        --             Function = 10,
        --             Method = 10,
        --             Operator = 10,
        --             Reference = 10,
        --             Struct = 10,
        --             Variable = 9,
        --             File = 8,
        --             Folder = 8,
        --             Class = 5,
        --             Color = 5,
        --             Module = 5,
        --             Keyword = 2,
        --             Constructor = 1,
        --             Interface = 1,
        --             Text = 1,
        --             TypeParameter = 1,
        --             Unit = 1,
        --             Value = 1,
        --             Snippet = 0,
        --         },
        --     }),
        --     label_comparator,
        -- },
    },
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered({
            border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'},
        }),
        documentation = cmp.config.window.bordered({
            border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'},
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ['<c-k>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<c-j>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            select = true,
        })
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
      { name = 'path' },
    }),
    experimental = {
        ghost_text = true,
    }
})
