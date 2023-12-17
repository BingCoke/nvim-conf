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
		},
		-- 窗口内快捷键
		mappings = require("keybindings").telescopeList,
	},
	pickers = {
		-- 内置 pickers 配置
		find_files = {
			-- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
			-- theme = "dropdown",
		},
	},
	extensions = {
		["uo-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		project = {
			hidden_files = true, -- default: false
			search_by = "title",
			-- default for on_project_selected = find project files
		},
		file_browser = {
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = false,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					-- your custom normal mode mappings
				},
			},
		},
	},
})

--require("telescope").load_extension("file_browser")
require("telescope").load_extension("projects")
--require'telescope'.extensions.projects.projects{}
require("telescope").load_extension("ui-select")
--require("telescope").load_extension("project")
