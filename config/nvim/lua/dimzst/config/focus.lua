require('focus').setup({
    hybridnumber = true,
    cursorline = true,
    excluded_filetypes = {"fugitiveblame", "alpha"},
})

local tz_callbacks = {
    open_pre = function()
        require('focus').focus_disable()
    end,
    open_pos = nil,
    close_pre = nil,
    close_pos = function()
        require('focus').focus_enable()
    end,
}

local tz = require('true-zen')
tz.setup( {
	modes = { -- configurations per mode
        ataraxis = {
            shade = "dark", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
            backdrop = 0, -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
            minimum_writing_area = { -- minimum size of main window
                width = 50,
                height = 44,
            },
            quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
            padding = { -- padding windows
                left = 50,
                right = 50,
                top = 0,
                bottom = 0,
            },
            callbacks = tz_callbacks,
        },
        minimalist = {
            ignored_buf_types = { "nofile" }, -- save current options from any window except ones displaying these kinds of buffers
            options = { -- options to be disabled when entering Minimalist mode
                number = false,
                relativenumber = false,
                showtabline = 0,
                signcolumn = "no",
                statusline = "",
                cmdheight = 1,
                laststatus = 0,
                showcmd = false,
                showmode = false,
                ruler = false,
                numberwidth = 1
            },
            callbacks = tz_callbacks,
        },
        narrow = {
            --- change the style of the fold lines. Set it to:
            --- `informative`: to get nice pre-baked folds
            --- `invisible`: hide them
            --- function() end: pass a custom func with your fold lines. See :h foldtext
            folds_style = "informative",
            run_ataraxis = true, -- display narrowed text in a Ataraxis session
            callbacks = {
                open_pre = nil,
                open_pos = nil,
                close_pre = nil,
                close_pos = nil
            }
        },
        focus = {
            callbacks = tz_callbacks,
        }
    },
    integrations = {
        tmux = true, -- hide tmux status bar in (minimalist, ataraxis)
        kitty = { -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
            enabled = false,
            font = "+3"
        },
        twilight = false, -- enable twilight (ataraxis)
        lualine = true -- hide nvim-lualine (ataraxis)
    },
})

vim.keymap.set('n', '<leader>za', tz.ataraxis, { noremap = true })
vim.keymap.set('n', '<leader>zn', function()
    local first = 0
    local last = vim.api.nvim_buf_line_count(0)
    tz.narrow(first, last)
end, { noremap = true })
vim.keymap.set('v', '<leader>zn', function()
    local first = vim.fn.line('v')
    local last = vim.fn.line('.')
    tz.narrow(first, last)
end, { noremap = true })
