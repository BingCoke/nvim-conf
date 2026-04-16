return {
	{
		"folke/tokyonight.nvim",
		--"catppuccin/nvim",
		--name = "catppuccin",
		lazy = false,
		priority = 1000,
		dependencies = {},
		config = function()
			require("colorscheme")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("plugin-config.neotree")
		end,
		enabled = false,
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("plugin-config.nvim-tree")
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
		},
		config = function()
			require("plugin-config.lualine")
			require("transparent").clear_prefix("lualine")
		end,
		event = "VeryLazy",
	},
	{
		--event = "VeryLazy",
		"romgrk/barbar.nvim",
		event = "VimEnter",
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		config = function()
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
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	-- 启动页面
	-- dashboard-nvim
	{
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		config = function(self, opts)
			require("plugin-config.nvim-web-devicions")
		end,
	},
	{
		"glepnir/dashboard-nvim",
		config = function()
			require("plugin-config.dashboard")
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"keaising/im-select.nvim",
		config = function()
			local im = ""
			if OS == "Darwin" then
				im = "com.apple.keylayout.ABC"
			end
			require("im_select").setup({
				default_im_select = im,
			})
		end,
		--event = "BufReadPre",
		enabled = false,
	},
	{
		"uga-rosa/ccc.nvim",
		config = function()
			require("ccc").setup({})
		end,
		event = "VeryLazy",
		--enabled = false
	},
	{
		"vhyrro/luarocks.nvim",
		event = "VeryLazy",
		opts = {
			rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }, -- Specify LuaRocks packages to install
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("plugin-config.toggleterm")
		end,
	},
	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup({
				exclude_groups = {
					"CursorLine",
					"CursorLineNr",
					--"NoiceCursor",
					--"Underlined",
				},
			})
			require("transparent").clear_prefix("BufferLine")
			require("transparent").clear_prefix("NeoTree")
			require("transparent").clear_prefix("lualine")
			require("transparent").clear_prefix("Lsp")
			require("transparent").clear_prefix("Noice")
			require("transparent").clear_prefix("Saga")
			--require("transparent").clear_prefix("Float")
			require("transparent").clear("HoverBorder")
			require("transparent").clear("Pmenu")
			require("transparent").clear("NotifyBackground")
			require("transparent").clear("BufferTabpagesSep")
			require("transparent").clear("BufferTabpages")
		end,
	},
}
