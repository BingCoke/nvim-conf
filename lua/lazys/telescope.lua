return {
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		config = function()
			local status, project = pcall(require, "project_nvim")
			if not status then
				vim.notify("没有找到 project_nvim")
				return
			end

			-- nvim-tree 支持
			project.setup({
				--manual_mode = false,
				detection_methods = { "pattern" },
				patterns = {
					".git",
					".svn",
					".idea",
				},
				show_hidden = true,
				exclude_dirs = { "~/.cargo/*" },
			})

			local telescope = require("telescope")
			pcall(telescope.load_extension, "projects")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local status, telescope = pcall(require, "telescope")
			if not status then
				vim.notify("没有找到 telescope")
				return
			end

			telescope.setup({
				defaults = {
					-- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
					initial_mode = "insert",

					file_ignore_patterns = {
						"node_modules",
						"vendor",
						"ios",
						"andriod",
					},
					-- 窗口内快捷键
					mappings = {
						i = {
							-- 上下移动
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
							["<Down>"] = "move_selection_next",
							["<Up>"] = "move_selection_previous",
							-- 历史记录
							["<C-n>"] = "cycle_history_next",
							["<C-p>"] = "cycle_history_prev",
							-- 关闭窗口
							["<C-c>"] = "close",
							-- 预览窗口上下滚动
							["<C-u>"] = "preview_scrolling_up",
							["<C-d>"] = "preview_scrolling_down",
							["<C-l>"] = "results_scrolling_right",
							["<C-h>"] = "results_scrolling_left",
							["<C-v>"] = function(prompt_bufnr)
								-- 触发 Vim 的插入模式 Ctrl+r 然后 + 寄存器
								local keys = vim.api.nvim_replace_termcodes("<C-r>+", true, false, true)
								vim.api.nvim_feedkeys(keys, "t", true)
							end,
							-- ["<c-s>"] = "file_split",
							-- ["<c-v>"] = "file_vsplit",
							["<c-o>"] = "select_tab_drop",
						},
					},
				},
				pickers = {
					-- 内置 pickers 配置
					find_files = {
						-- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
						-- theme = "dropdown",
						mappings = {
							i = {
								["<cr>"] = "select_tab_drop",
								["<c-o>"] = "select_drop",
							},
						},
					},
					buffers = {
						mappings = {
							i = {
								["<cr>"] = "select_drop",
								["<c-o>"] = "select_drop",
							},
						},
					},
				},

				extensions = {
					["uo-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					project = {
						hidden_files = true, -- default: false
						search_by = "title",
					},
					my_file_find = {},
					file_browser = {
						-- disables netrw and use telescope-file-browser in its place
						--hijack_netrw = false,
						mappings = {
							["i"] = {
								-- your custom insert mode mappings
							},
							["n"] = {
								-- your custom normal mode mappings
							},
						},
					},
					myprojects = {},
				},
			})

			require("telescope").load_extension("myprojects")
			require("telescope").load_extension("my_file_find")
			require("telescope").load_extension("ui-select")
		end,
	},
}
