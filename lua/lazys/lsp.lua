local c = require("language")
local language = c.language
local js = c.ts

return {
	------- LSP -----
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"onsails/lspkind.nvim",
			{
				"nvimdev/lspsaga.nvim",
			},
		},
		config = function()
			require("lsp.mason")
			require("lsp.lsp")
			require("lsp.languages")
		end,
		ft = language,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
			},
		},
	},
	{
		"onsails/lspkind.nvim",
		event = "VeryLazy",
		config = function()
			require("lspkind").init({
				mode = "symbol_text",
			})
		end,
	},
	-- JSON 增强
	{
		"b0o/schemastore.nvim",
		dependencies = {},
		config = function() end,
		ft = {
			"json",
			"jsonc",
		},
	},
	-- enhanced lsp uis
	{
		"jinzhongjia/LspUI.nvim",
		ft = language,
		branch = "main",
		config = function()
			require("LspUI").setup({
				-- config options go here
				lightbulb = { enable = false },
				inlay_hint = { enable = false },
			})
		end,
		enabled = false,
	},
	{
		"DNLHC/glance.nvim",
		config = function()
			--require("plugin-config.glance")
		end,
		enabled = false,
		ft = language,
	},

	{
		"olexsmir/gopher.nvim",
		ft = "go",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
		},
		-- (optional) will update plugin's deps on every update
		build = function()
			--vim.cmd.GoInstallDeps()
		end,
	},
	-- language ts
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			--require("plugin-config.color")
		end,
		ft = language,
	},
	{
		"NMAC427/guess-indent.nvim",
		enable = false,
		config = function()
			require("guess-indent").setup({
				auto_cmd = true, -- Set to false to disable automatic execution
				override_editorconfig = false, -- Set to true to override settings set by .editorconfig
				filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
					"netrw",
					"tutor",
				},
				buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
					"help",
					"nofile",
					"terminal",
					"prompt",
				},
			})
		end,
		ft = language,
	},
	{
		"yioneko/nvim-vtsls",
		ft = js,
		config = function()
			require("vtsls").config({})
		end,
	},
	{
		"folke/trouble.nvim",
		ft = language,
		config = function()
			require("config.trouble")
		end,
	},
}
