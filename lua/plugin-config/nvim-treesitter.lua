local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	vim.notify("没有找到 nvim-treesitter")
	return
end

treesitter.setup({
	-- 安装 language parser
	-- :TSInstallInfo 命令查看支持的语言
	ensure_installed = {
		"rust",
		"json",
		"html",
		"css",
		"vim",
		"lua",
		"javascript",
		"typescript",
		"vue",
		"tsx",
		"java",
		"yaml",
		"go",
		"markdown",
		"markdown_inline",
	},
	-- 启用代码高亮模块
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		disable = function(_, bufnr)
			return vim.api.nvim_buf_line_count(bufnr) > 5000
		end,
	},
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = 10000, -- Do not enable for files with more than n lines, int
		colors = {
			"#95ca60",
			"#ee6985",
			"#D6A760",
			"#7794f4",
			"#b38bf5",
			"#7cc7fe",
		}, -- table of hex strings
		-- termcolors = { } -- table of colour name strings
	},
	-- 启用增量选择模块
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<BS>",
		},
	},
	-- 启用代码缩进模块 (=)
	indent = {
		enable = false,
	},
	autotag = {
		enable = true,
		enable_rename = true,
		enable_close = true,
		enable_close_on_slash = true,
	},
})
-- 开启 Folding 模块
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldlevel = 99
