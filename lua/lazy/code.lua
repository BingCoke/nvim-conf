local g = require("gConfig")
local language = g.language
local ts = g.ts

return {
	{
		"windwp/nvim-autopairs",
		dependencies = {},
		config = function()
			require("plugin-config.autopairs")
		end,
		event = "VeryLazy",
	},
	--{
	--	"simrat39/symbols-outline.nvim",
	--	config = function()
	--		require("plugin-config.symbols-outline")
	--	end,
	--	ft = language,
	--},
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
		enabled = true,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
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
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({})
		end,
		enabled = true,
		ft = language,
	},
	---- 折叠
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
	{
		"numToStr/prettierrc.nvim",
		ft = ts,
		enabled = false,
	},
	{
		"luozhiya/fittencode.nvim",
		ft = language,
		config = function()
			require("plugin-config.fitten")
		end,
		enabled = false,
	},
	{
		"milanglacier/minuet-ai.nvim",
		ft = language,
		enabled = false,
		config = function()
			require("minuet").setup({
				virtualtext = {
					auto_trigger_ft = { "*" },
					keymap = {
						-- accept whole completion
						accept = "<A-l>",
						-- accept one line
						accept_line = "<A-a>",
						-- accept n lines (prompts for number)
						-- e.g. "A-z 2 CR" will accept 2 lines
						--accept_n_lines = "<A-z>",
						-- Cycle to prev completion item, or manually invoke completion
						prev = "<A-[>",
						-- Cycle to next completion item, or manually invoke completion
						next = "<A-]>",
						--dismiss = "<A-e>",
					},
				},
				provider = "claude",
				provider_options = {
					claude = {
						max_tokens = 2569,
						api_key = "ANTHROPIC_AUTH_TOKEN",
						stream = true,
						end_point = "https://api.xheai.cc/v1/messages",
					},
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		event = "VeryLazy",
		enabled = false,
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
	{
		"mfussenegger/nvim-lint",
		--enabled = false,
		config = function()
			require("lint").linters_by_ft = {
				proto = { "buf_lint" },
				make = { "checkmake" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{
		"edolphin-ydf/goimpl.nvim",
		--enabled = false,
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("telescope").load_extension("goimpl")
			vim.api.nvim_set_keymap(
				"n",
				"<leader>mi",
				[[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]],
				{ noremap = true, silent = true }
			)
		end,
		ft = "go",
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		enabled = false,
		--version = false, -- set this if you want to always pull the latest change
		ft = language,
		config = function()
			require("plugin-config.avante")
		end,
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"MeanderingProgrammer/render-markdown.nvim",
		},
	},
	{
		"wojciech-kulik/xcodebuild.nvim",
		config = function()
			require("plugin-config.xcode")
		end,
		ft = "swift",
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			vim.diagnostic.config({ virtual_text = false })
			local tiny = require("tiny-inline-diagnostic")
			tiny.setup({})
		end,
		ft = language,
	},
	{
		"code-biscuits/nvim-biscuits",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-biscuits").setup({
				on_events = { "InsertLeave", "CursorHoldI" },
			})
		end,
		ft = language,
	},
}
