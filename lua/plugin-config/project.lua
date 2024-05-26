local status, project = pcall(require, "project_nvim")
if not status then
	vim.notify("没有找到 project_nvim")
	return
end

-- nvim-tree 支持
project.setup({
	detection_methods = { "pattern" },
	patterns = {
		--"!>app",
		".git",
		"!>node_modules",
		--"!>packages",
		--"!>apps",
		"tourbo.json",
		"_darcs",
		".hg",
		".bzr",
		".svn",
		"Makefile",
		"package.json",
		".sln",
		".idea",
	},
	show_hidden = true,
	exclude_dirs = { "~/.cargo/*" },
})

local telescope = require("telescope")
pcall(telescope.load_extension, "projects")
