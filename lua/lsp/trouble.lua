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
