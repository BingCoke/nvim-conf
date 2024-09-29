return {

	{
		"folke/tokyonight.nvim",
		--"catppuccin/nvim",
		--name = "catppuccin",
		lazy = false,
		priority = 1000,
		dependencies = {
			"tanvirtin/monokai.nvim",
			--"EdenEast/nightfox.nvim",
			--{ "diegoulloao/neofusion.nvim", priority = 1000, config = true },
		},
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
		config = function(self, opts)
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
			--"folke/tokyonight.nvim",
		},
		config = function()
			require("plugin-config.lualine")
			require("transparent").clear_prefix("lualine")
		end,
		event = "VeryLazy",
	},
	--{
	--	"romgrk/barbar.nvim",
	--	dependencies = {
	--		-- 页面关闭
	--		"moll/vim-bbye",
	--	},
	--	config = function(self, opts)
	--		vim.g.barbar_auto_setup = false
	--		require("plugin-config.barbar")
	--	end,
	--	enabled = false,
	--},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		lazy = false,
		priority = 1000,
		event = "VeryLazy",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("plugin-config.bufferline")
			vim.api.nvim_create_autocmd("BufAdd", {
				callback = function()
					vim.schedule(function()
						---@diagnostic disable-next-line: undefined-global
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
		--event = "VeryLazy",
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
	-- 启动页面
	-- dashboard-nvim
	{
		"nvim-tree/nvim-web-devicons",
		config = function(self, opts)
			require("plugin-config.nvim-web-devicions")
		end,
	},
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
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
		event = "BufReadPre",
		--enabled = false,
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
		{
			"gbprod/yanky.nvim",
			--enabled = false,
			dependencies = {
				"kkharji/sqlite.lua",
			},
			config = function()
				local mapping = require("yanky.telescope.mapping")
				local utils = require("yanky.utils")
				vim.keymap.set("n", "<leader>y", ":Telescope yank_history<CR>")
				-- vim.keymap.set("n", "<c-u>", "<Plug>(YankyCycleForward)")
				-- vim.keymap.set("n", "<c-e>", "<Plug>(YankyCycleBackward)")
				vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
				vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
				vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
				vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

				require("yanky").setup({
					ring = {
						history_length = 2000,
						storage = "sqlite",
						sync_with_numbered_registers = true,
						cancel_event = "update",
					},
					picker = {
						select = {
							action = nil, -- nil to use default put action
						},
						telescope = {
							use_default_mappings = false, -- if default mappings should be used
							mappings = {
								n = {
									p = mapping.put("p"),
									P = mapping.put("P"),
									d = mapping.delete(),
									r = mapping.set_register(utils.get_default_register()),
								},
								i = {
									["<CR>"] = mapping.put("p"),
									["<c-g>"] = mapping.put("P"),
									["<c-x>"] = mapping.delete(),
									["<c-r>"] = mapping.set_register(utils.get_default_register()),
								},
							}, -- nil to use default mappings or no mappings (see `use_default_mappings`)
						},
					},
					system_clipboard = {
						sync_with_ring = true,
					},
					highlight = {
						on_put = false,
						on_yank = false,
						timer = 300,
					},
					preserve_cursor_position = {
						enabled = true,
					},
				})
			end,
		},
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
		config = function()
			require("plugin-config.toggleterm")
		end,
	},
	{
		"rest-nvim/rest.nvim",
		dependencies = {
			"vhyrro/luarocks.nvim",
		},
		config = function()
			require("plugin-config.http")
		end,
		enabled = false,
		event = "VeryLazy",
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
			require("transparent").clear_prefix("Float")
			require("transparent").clear("HoverBorder")
			require("transparent").clear("Pmenu")
			require("transparent").clear("NotifyBackground")
		end,
		--event = "VeryLazy",
		--lazy = false,
		--priority = 1000,
		--enabled = false
	},
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		enabled = false,
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<M-f>",
				"<cmd>Yazi toggle<cr>",
				desc = "Open the file manager",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				function()
					require("yazi").yazi(nil, vim.fn.getcwd())
				end,
				desc = "Open the file manager in nvim's working directory",
			},
		},
		---@type YaziConfig
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			use_ya_for_events_reading = true,
			use_yazi_client_id_flag = "nvim",
			highlight_hovered_buffers_in_same_directory = false,
			highlight_groups = {
				-- See https://github.com/mikavilpas/yazi.nvim/pull/180
				hovered_buffer = nil,
				-- See https://github.com/mikavilpas/yazi.nvim/pull/351
				hovered_buffer_in_same_directory = nil,
			},
			keymaps = {
				show_help = "<f1>",
				open_file_in_vertical_split = "<c-v>",
				open_file_in_horizontal_split = "<c-x>",
				open_file_in_tab = "<cr>",
				grep_in_directory = "<c-s>",
				replace_in_directory = "<c-g>",
				cycle_open_buffers = "<tab>",
				copy_relative_path_to_selected_files = "<c-y>",
				send_to_quickfix_list = "<c-q>",
				change_working_directory = "<c-\\>",
			},
			hooks = {
				-- if you want to execute a custom action when yazi has been opened,
				-- you can define it here.
				yazi_opened = function(preselected_path, yazi_buffer_id, config)
					local opt = { buffer = yazi_buffer_id }
					vim.keymap.set({ "i", "t" }, "<M-f>", "<cmd>Yazi toggle<cr>", opt)
					-- you can optionally modify the config for this specific yazi
					-- invocation if you want to customize the behaviour
				end,

				-- when yazi was successfully closed
				yazi_closed_successfully = function(chosen_file, config, state) end,

				-- when yazi opened multiple files. The default is to send them to the
				-- quickfix list, but if you want to change that, you can define it here
				yazi_opened_multiple_files = function(chosen_files, config, state) end,
			},
		},
	},
}
