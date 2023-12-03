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
local ts = {
	"html",
	"typescript",
	"typescriptreact",
	"javascript",
	"javascriptreact",
}

return {

	{
		"simrat39/symbols-outline.nvim",
		config = function(opts, self)
			require("plugin-config.symbols-outline")
		end,
		ft = language,
	},
	{
		"nvimdev/guard.nvim",
		dependencies = {
			"nvimdev/guard-collection",
		},
		config = function(self, opts)
			require("plugin-config.guard")
		end,
		ft = language,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("plugin-config.illuminate")
		end,
		ft = language,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugin-config.nvim-treesitter")
		end,
		ft = language,
	},
	--[[{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},]]
	-- 折叠
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("plugin-config.ufo")
		end,
		ft = language,
	},
	-- 注释
	{
		"numToStr/comment.nvim",
		config = function()
			require("plugin-config.coment")
		end,
		ft = language,
	},
	-- 线
	{
		"yaocccc/nvim-hlchunk",
		config = function() end,
		ft = language,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function(self, opts)
			vim.g.indent_blankline_filetype_exclude = {
				"lspinfo",
				"packer",
				"checkhealth",
				"help",
				"man",
				"dashboard",
			}
			vim.g.indentLine_fileTypeExclude = {
				"lspinfo",
				"packer",
				"checkhealth",
				"help",
				"man",
				"dashboard",
			}
			require("ibl").setup({})
		end,
		ft = language,
	},
	{
		"numToStr/prettierrc.nvim",
		ft = ts,
	},
	{
		"zbirenbaum/copilot.lua",
		event = "VeryLazy",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
				},
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signcoumn = true,
			sign_priority = 1,
		},
	},
}
