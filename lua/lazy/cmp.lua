return {
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"honza/vim-snippets",
			"rafamadriz/friendly-snippets", -- useful snippets
			"jcha0713/cmp-tw2css",
			{
				"js-everts/cmp-tailwind-colors",
				opts = {},
				config = function()
					require("cmp-tailwind-colors").setup({})
				end,
			},
		},
		event = "BufReadPre",
		config = function(self, opts)
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
			--"SirVer/ultisnips",
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
			-- require("crates").setup({
			--[[ null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      }) ]]
			local cmp = require("cmp")
			cmp.setup.buffer({ sources = { { name = "crates" } } })
		end,
		--  event = "BufEnter Cargo.toml",
		ft = { "toml" },
	},

	-- autopairs
	{
		"windwp/nvim-autopairs",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("plugin-config.autopairs")
		end,
		event = "VeryLazy",
	},
	{
		"David-Kunz/cmp-npm",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "json",
		config = function()
			require("cmp-npm").setup({})
		end,
	},
}
