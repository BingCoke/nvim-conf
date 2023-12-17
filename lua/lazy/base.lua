return {

	{
		"folke/tokyonight.nvim",
		config = function()
			require("colorscheme")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function(self, opts)
			require("plugin-config.neotree")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("plugin-config.project")
		end,
		lazy = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"folke/tokyonight.nvim",
		},
		config = function()
			require("plugin-config.lualine")
		end,
		event = "VeryLazy",
	},
	{
		"romgrk/barbar.nvim",
		--event = { "VeryLazy" },
		dependencies = {
			--"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
			-- 页面关闭
			"moll/vim-bbye",
		},
		config = function(self, opts)
			vim.g.barbar_auto_setup = false
			require("plugin-config.barbar")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("plugin-config.telescope")
		end,
	},
	-- 启动页面
	-- dashboard-nvim
	{
		"nvim-tree/nvim-web-devicons",
		priority = 70,
		config = function(self, opts)
			require("plugin-config.nvim-web-devicions")
		end,
		event = "VeryLazy",
	},
	{
		"glepnir/dashboard-nvim",
		event = "UIEnter",
		config = function()
			require("plugin-config.dashboard")
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"h-hg/fcitx.nvim",
		event = "BufReadPre",
	},
	{
		"uga-rosa/ccc.nvim",
		config = function()
			require("ccc").setup({})
		end,
		event = "VeryLazy",
	},
	{
		{
			"gbprod/yanky.nvim",
			enabled = false,
			dependencies = {
				"kkharji/sqlite.lua",
			},
			config = function()
				local mapping = require("yanky.telescope.mapping")
				local utils = require("yanky.utils")
				vim.keymap.set("n", "<leader>y", ":Telescope yank_history<CR>")
				-- vim.keymap.set("n", "<c-u>", "<Plug>(YankyCycleForward)")
				-- vim.keymap.set("n", "<c-e>", "<Plug>(YankyCycleBackward)")
				vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
				vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
				vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
				vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

				require("yanky").setup({
					ring = {
						history_length = 2000,
						storage = "sqlite",
						sync_with_numbered_registers = true,
						cancel_event = "update",
					},
					picker = {
						select = {
							action = nil, -- nil to use default put action
						},
						telescope = {
							use_default_mappings = false, -- if default mappings should be used
							mappings = {
								n = {
									p = mapping.put("p"),
									P = mapping.put("P"),
									d = mapping.delete(),
									r = mapping.set_register(utils.get_default_register()),
								},
								i = {
									["<CR>"] = mapping.put("p"),
									["<c-g>"] = mapping.put("P"),
									["<c-x>"] = mapping.delete(),
									["<c-r>"] = mapping.set_register(utils.get_default_register()),
								},
							}, -- nil to use default mappings or no mappings (see `use_default_mappings`)
						},
					},
					system_clipboard = {
						sync_with_ring = true,
					},
					highlight = {
						on_put = false,
						on_yank = false,
						timer = 300,
					},
					preserve_cursor_position = {
						enabled = true,
					},
				})
			end,
		},
	},
}
