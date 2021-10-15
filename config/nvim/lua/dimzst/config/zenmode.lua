require("zen-mode").setup {
	on_open = function(win)
		require('focus').focus_disable()
	end,
	-- callback where you can add custom code when the Zen window closes
	on_close = function()
		require('focus').focus_enable()
	end,
}
