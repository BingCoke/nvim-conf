local g = require("gConfig")
local language = g.language
local js = g.ts
return {
	------- LSP -----
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("lsp.mason")
			require("lsp.lsp")
		end,
		ft = language,
		event = { "VeryLazy" },
	},
	{
		"kaarmu/typst.vim",
		ft = "typst",
		event = "VeryLazy",
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
		"someone-stole-my-name/yaml-companion.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("yaml_schema")
		end,
		event = "VeryLazy",
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function()
			local mlsp = require("lsp.lsp")
			require("lsp.language.typescript").setup(mlsp.lspconfig, mlsp.default_capabilities, mlsp.on_attach)
		end,
		ft = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"mdx",
			"vue",
		},
		--enabled = false,
	},
	{
		"onsails/lspkind.nvim",
		event = "VeryLazy",
		config = function()
			require("lsp.lspkind")
		end,
		--event = "VeryLazy",
	},
	-- JSON 增强
	{
		"b0o/schemastore.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			-- code
			require("language.json")
		end,
		ft = {
			"json",
			"jsonc",
		},
	},
	--- flutter
	{
		"akinsho/flutter-tools.nvim",
		--dir = "/home/bk/tmp/flutter-tools.nvim",
		requires = {
			"stevearc/dressing.nvim", -- optional for vim.ui.select
			"mfussenegger/nvim-dap",
			"neovim/nvim-lspconfig",
		},

		config = function()
			local mlsp = require("lsp.lsp")
			require("lsp.language.flutter").setup(mlsp.lspconfig, mlsp.default_capabilities, mlsp.on_attach)
		end,
		ft = "dart",
	},
	{
		"nvimdev/lspsaga.nvim",
		branch = "main",
		config = function()
			require("lsp.saga")
		end,
		ft = language,
	}, -- enhanced lsp uis
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
	},
	{
		"DNLHC/glance.nvim",
		config = function()
			require("plugin-config.glance")
		end,
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
		config = function()
			require("language.go")
		end,
		-- (optional) will update plugin's deps on every update
		build = function()
			vim.cmd.GoInstallDeps()
		end,
	},
	-- language ts
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = language,
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("plugin-config.color")
		end,
		event = "VeryLazy",
	},
	{
		"dart-lang/dart-vim-plugin",
		config = function()
			vim.g.dart_format_on_save = false
			vim.g.dart_style_guide = 2
			vim.g.dart_trailing_comma_indent = true
		end,
		ft = "dart",
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
			require("lsp.trouble")
			vim.keymap.set("n", "<leader>xx", function()
				require("trouble").toggle()
			end)
			vim.keymap.set("n", "<leader>xw", function()
				require("trouble").toggle("workspace_diagnostics")
			end)
			vim.keymap.set("n", "<leader>xd", function()
				require("trouble").toggle("document_diagnostics")
			end)
			vim.keymap.set("n", "<leader>xq", function()
				require("trouble").toggle("quickfix")
			end)
			vim.keymap.set("n", "<leader>xl", function()
				require("trouble").toggle("loclist")
			end)
			vim.keymap.set("n", "gR", function()
				require("trouble").toggle("lsp_references")
			end)
		end,
	},

}
