return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function(self, opts)
			require("plugin-config.noice")
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(self, opts)
			require("plugin-config.flash")
		end,
	},
	-- floaterm
	{
		"voldikss/vim-floaterm",
		config = function()
			require("plugin-config.fterm").setup()
			require("plugin-config.fterm").config()
		end,
		event = "VeryLazy",
	},
}
