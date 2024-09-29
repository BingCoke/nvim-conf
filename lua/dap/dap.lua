-- set 断点的图标
local dap = require("dap")
dap.defaults.fallback.switchbuf = "useopen,usetab,newtab"

dap.defaults.fallback.focus_terminal = true
dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
dap.defaults.fallback.external_terminal = {
	command = "kitty",
	args = { "-1" },
}

local dap_breakpoint = {
	error = {
		text = "E",
		texthl = "LspDiagnosticsSignError",
		linehl = "",
		numhl = "",
	},
	rejected = {
		text = "",
		texthl = "LspDiagnosticsSignHint",
		linehl = "",
		numhl = "",
	},
	stopped = {
		text = "⭐️",
		texthl = "LspDiagnosticsSignInformation",
		linehl = "DiagnosticUnderlineInfo",
		numhl = "LspDiagnosticsSignInformation",
	},
}

vim.api.nvim_set_hl(0, "Breakpoint", { fg = "#e35a60" })
vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Breakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "Breakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "orange", linehl = "Breakpoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "green", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "yellow", numhl = "DapBreakpoint" })
