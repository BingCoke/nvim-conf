require("util.cmpUtil").blinkCmp = false
return {
	{
		"L3MON4D3/LuaSnip",
		version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		build = "make install_jsregexp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"honza/vim-snippets",
			"jcha0713/cmp-tw2css",
		},
		event = "BufReadPre",
		config = function()
			require("luasnip").config.setup({
				history = true,
				--region_check_events = 'CursorMoved'
			})
		end,
		--enabled = false,
	},
	-- cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- for autocompletion
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
		},
		event = "VeryLazy",
		config = function()
			require("lsp.cmp")
		end,
	},
	{
		"saecki/crates.nvim",
		tag = "v0.3.0",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			local cmp = require("cmp")
			cmp.setup.buffer({ sources = { { name = "crates" } } })
		end,
		--  event = "BufEnter Cargo.toml",
		ft = { "toml" },
	},
}
