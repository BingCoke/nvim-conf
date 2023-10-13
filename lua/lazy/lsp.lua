local M = {}
local language = {
	"ruby",
	"awk",
	"c",
	"cpp",
	"dart",
	"rust",
	"go",
	"python",
	"html",
	"css",
	"markdown",
	"yaml",
	"yml",
	"json",
	"jsonc",
	"lua",
	"xml",
	"sh",
	"toml",
	"typst",
	"sql",
	"typescript",
	"typescriptreact",
	"javascript",
	"javascriptreact",
	"kotlin",
	"prisma",
}
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
		"lvimuser/lsp-inlayhints.nvim",
		config = function(self)
			require("lsp.inlayghints")
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
				callback = function(args)
					if not (args.data and args.data.client_id) then
						return
					end
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					require("lsp-inlayhints").on_attach(client, args.buf)
				end,
			})
		end,
		ft = language,
	},
	{
		"kaarmu/typst.vim",
		ft = "typst",
		event = "VeryLazy",
	},

	{
		"folke/neodev.nvim",
		config = function(self, opts)
			require("neodev").setup({
				-- add any options here, or leave empty to use the default settings
			})
		end,
		ft = {
			"lua",
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
		--dir = "/home/bk/tmp/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function(self, opts)
			local mlsp = require("lsp.lsp")
			require("lsp.language.typescript").setup(mlsp.lspconfig, mlsp.default_capabilities, mlsp.on_attach)
		end,
		ft = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
	},
	{
		"onsails/lspkind.nvim",
		config = function(self, opts)
			require("lsp.lspkind")
		end,
		event = "VeryLazy",
	},
	-- JSON 增强
	{
		"b0o/schemastore.nvim",
		config = function()
			-- code
			require("language.json")
		end,
		ft = language,
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
		"DNLHC/glance.nvim",
		config = function(self, opts)
			require("plugin-config.glance")
		end,
		ft = language,
	},

	-- language go
	{
		"ray-x/go.nvim",
		dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig" },
		config = function()
			require("language.go")
		end,
		--event = "BufEnter *.go",
		ft = "go",
	},
	-- language ts
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = language,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function(self, opts)
			require("plugin-config.color")
		end,
		ft = {
			"css",
			"scss",
			"html",
			"javascript",
			"typescript",
			"typescriptreact",
			"javascriptreact",
		},
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
	},
}
