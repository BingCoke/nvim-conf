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

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
