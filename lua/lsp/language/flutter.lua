local M = {}
local preview_stack_trace = function()
	local line = vim.api.nvim_get_current_line()
	local pattern = "package:[^/]+/([^:]+):(%d+):(%d+)"
	local filepath, line_nr, column_nr = string.match(line, pattern)
	if filepath and line_nr and column_nr then
		vim.cmd(":wincmd k")
		vim.cmd("e " .. filepath)
		vim.api.nvim_win_set_cursor(0, { tonumber(line_nr), tonumber(column_nr) })
		vim.cmd(":wincmd j")
	end
end

local keymap = vim.keymap -- for conciseness

function M.setup(lspconfig, capabilities, on_attach)
	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "__FLUTTER_DEV_LOG__",
		callback = function()
			vim.keymap.set("n", "gd", preview_stack_trace, { silent = true, noremap = true, buffer = true })
		end,
	})
	require("flutter-tools").setup({
		fvm = true,
		ui = {
			border = "rounded",
			notification_style = "nvim-notify",
		},
		dev_tools = {
			autostart = false, -- autostart devtools server if not detected
			auto_open_browser = true, -- Automatically opens devtools in the browser
		},
		widget_guides = {
			enabled = true,
		},
		dev_log = {
			enabled = true,
			notify_errors = true, -- if there is an error whilst running then notify the user
			open_cmd = "edit", -- command to use to open the log buffer
		},
		lsp = {
			on_attach = on_attach,
			capabilities = capabilities,
			color = {
				enabled = true,
			},
			settings = {
				analysisExcludedFolders = {
					vim.fn.expand("$HOME/.pub-cache"),
					vim.fn.expand("$HOME/fvm"),
				},
				lineLength = 100,
			},
		},
		debugger = {
			enabled = true,
			run_via_dap = true,
			exception_breakpoints = {},
			register_configurations = function(paths)
				require("dap").configurations.dart = {
					{
						name = "launch",
						request = "launch",
						type = "dart",
					},
					{
						name = "profile",
						request = "launch",
						type = "dart",
						flutterMode = "profile",
					},
					{
						name = "release",
						request = "launch",
						type = "dart",
						flutterMode = "release",
					},
				}
			end,
		},
	})
end

return M
