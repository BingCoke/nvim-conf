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
	{
		"aserowy/tmux.nvim",
		config = function()
			local tmux = require("tmux")
			tmux.setup({
				navigation = {
					enable_default_keybindings = false,
				},
				resize = {
					enable_default_keybindings = false,
				},
			})
			local map = vim.keymap.set
			-- 复用 opt 参数
			local opt = { noremap = true, silent = true }
			map("n", "<A-h>", function()
				tmux.move_left()
			end, opt)
			map("n", "<A-j>", function()
				tmux.move_bottom()
			end, opt)
			map("n", "<A-k>", function()
				tmux.move_top()
			end, opt)
			map("n", "<A-l>", function()
				tmux.move_right()
			end, opt)

			map("n", "<C-Left>", function()
				tmux.resize_left()
			end, opt)
			map("n", "<C-Right>", function()
				tmux.resize_right()
			end, opt)
			map("n", "<C-Up>", function()
				tmux.resize_top()
			end, opt)
			map("n", "<C-Down>", function()
				tmux.resize_bottom()
			end, opt)
		end,
	},
}
