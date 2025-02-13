-- require("neoscroll").setup()

vim.api.nvim_create_autocmd({"TermOpen"}, {
    pattern = "*",
    command = "DisableWhitespace",
})

-- require("hlchunk").setup({
--     indent = {
--         enable = false,
--     },
--     line_num = {
--         enable = false,
--     },
--     blank = {
--         enable = false,
--     },
-- })

local augroup =
    vim.api.nvim_create_augroup('WinActiveHighLight', { clear = true })

vim.api.nvim_create_autocmd('WinEnter', {
    group = augroup,
    callback = function(_)
        vim.wo.cursorline = true
        vim.wo.colorcolumn = "80,120"
    end,
})

vim.api.nvim_create_autocmd('WinLeave', {
    group = augroup,
    callback = function(_)
        vim.wo.cursorline = false
        vim.wo.colorcolumn = "0"
    end,
})

-- require("notify").setup({
--   background_colour = "#000000",
-- })

-- require("noice").setup({
--     cmdline = {
--         enabled = true, -- enables the Noice cmdline UI
--         view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
--         opts = {}, -- extra opts for the cmdline view. See section on views
--         ---@type table<string, CmdlineFormat>
--         format = {
--             -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
--             -- view: (default is cmdline view)
--             -- opts: any options passed to the view
--             -- icon_hl_group: optional hl_group for the icon
--             cmdline = { pattern = "^:", icon = "", lang = "vim" },
--             search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
--             search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
--             filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
--             lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
--             help = { pattern = "^:%s*h%s+", icon = "" },
--             input = {}, -- Used by input()
--             -- lua = false, -- to disable a format, set to `false`
--         },
--     },
--     messages = {
--         -- NOTE: If you enable messages, then the cmdline is enabled automatically.
--         -- This is a current Neovim limitation.
--         enabled = true, -- enables the Noice messages UI
--         view = "notify", -- default view for messages
--         view_error = "notify", -- view for errors
--         view_warn = "notify", -- view for warnings
--         view_history = "split", -- view for :messages
--         view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
--     },
--     popupmenu = {
--         enabled = true, -- enables the Noice popupmenu UI
--         ---@type 'nui'|'cmp'
--         backend = "nui", -- backend to use to show regular cmdline completions
--         ---@type NoicePopupmenuItemKind|false
--         -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
--         kind_icons = {}, -- set to `false` to disable icons
--     },
--     ---@type NoiceRouteConfig
--     history = {
--         -- options for the message history that you get with `:Noice`
--         view = "split",
--         opts = { enter = true, format = "details" },
--         filter = { event = { "msg_show", "notify" }, ["not"] = { kind = { "search_count", "echo" } } },
--     },
--     notify = {
--         -- Noice can be used as `vim.notify` so you can route any notification like other messages
--         -- Notification messages have their level and other properties set.
--         -- event is always "notify" and kind can be any log level as a string
--         -- The default routes will forward notifications to nvim-notify
--         -- Benefit of using Noice for this is the routing and consistent history view
--         enabled = true,
--         view = "notify",
--     },
--     lsp_progress = {
--         enabled = true,
--         -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
--         -- See the section on formatting for more details on how to customize.
--         --- @type NoiceFormat|string
--         format = "lsp_progress",
--         --- @type NoiceFormat|string
--         format_done = "lsp_progress_done",
--         throttle = 1000 / 30, -- frequency to update lsp progress message
--         view = "mini",
--     },
--     throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
--     ---@type NoiceConfigViews
--     views = {}, ---@see section on views
--     ---@type NoiceRouteConfig[]
--     routes = {}, --- @see section on routes
--     ---@type table<string, NoiceFilter>
--     status = {}, --- @see section on statusline components
--     ---@type NoiceFormatOptions
--     format = {}, --- @see section on formatting
-- })
