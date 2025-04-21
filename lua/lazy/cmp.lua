local enabledCmp = true
return {
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		enabled = enabledCmp,
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"honza/vim-snippets",
			"jcha0713/cmp-tw2css",

		},
		event = "BufReadPre",
		config = function()
			require("util.cmpUtil").blinkCmp = false
			require("luasnip").config.setup({
				history = true,
				--region_check_events = 'CursorMoved'
			})
		end,
		--enabled = false,
	},
	{
		"lopi-py/blink.cmp",
		lazy = false, -- lazy loading handled internally
		enabled = not enabledCmp,
		-- optional: provides snippets for the snippet source
		dependencies = {
			--"hrsh7th/nvim-cmp",
		},
		version = "v0.*",

		opts = {
			keymap = {
				show = "<A-space>",
				hide = "<C-e>",
				accept = "<cr>",
				select_prev = { "<Up>", "<C-k>" },
				select_next = { "<Down>", "<C-j>" },
				show_documentation = {},
				hide_documentation = {},
				scroll_documentation_up = "<C-u>",
				scroll_documentation_down = "<C-d>",
				snippet_forward = "<c-l>",
				snippet_backward = "<c-h>",
			},
			highlight = {
				--use_nvim_cmp_as_default = true,
			},
			nerd_font_variant = "normal",
		},
	},
	-- cmp
	{
		"hrsh7th/nvim-cmp",
		enabled = enabledCmp,
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
		enabled = enabledCmp,
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			local cmp = require("cmp")
			cmp.setup.buffer({ sources = { { name = "crates" } } })
		end,
		--  event = "BufEnter Cargo.toml",
		ft = { "toml" },
	},
}
