local t_status, trouble = pcall(require, "trouble")

if not t_status then
	return
end

trouble.setup({
	focus = true,
	warn_no_results = false,
	modes = {
		preview_float = {
			mode = "diagnostics",
			preview = {
				type = "float",
				relative = "editor",
				border = "rounded",
				title = "Preview",
				title_pos = "center",
				position = { 0, -2 },
				size = { width = 0.3, height = 0.3 },
				zindex = 200,
			},
		},
	},
})

vim.keymap.set("n", "<leader>xx", function()
	troubletoggle()
end)
vim.keymap.set("n", "<leader>xw", function()
	trouble.toggle("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
	trouble.toggle("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
	trouble.toggle("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
	trouble.toggle("loclist")
end)
vim.keymap.set("n", "gR", function()
	trouble.toggle("lsp_references")
end)
