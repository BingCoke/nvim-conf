return {

	{
		"folke/tokyonight.nvim",
		config = function()
			require("colorscheme")
		end,
		lazy = true,
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
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
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
}
