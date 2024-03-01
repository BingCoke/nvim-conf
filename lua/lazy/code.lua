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
	"php",
	"mdx",
	"astro",
	"arduino",
	"http",
}
local ts = {
	"html",
	"typescript",
	"typescriptreact",
	"javascript",
	"javascriptreact",
	"mdx",
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
	{
		"HiPhish/rainbow-delimiters.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		ft = language,
	},
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
		dependencies = {
			{

				"JoosepAlviste/nvim-ts-context-commentstring",
				opts = {},
			},
		},
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
			sign_priority = 1,
		},
		ft = language,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("plugin-config.conform")
		end,
		event = "BufRead",
	},
}
