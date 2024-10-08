local dap = require("dap")

local map = vim.keymap.set
local opt = { noremap = true, silent = true }
local status_ok, dapui = pcall(require, "dapui")

if not status_ok then
	vim.notify("dapui not found")
	return
end
local dap_runner = require("dap.dap-runner")

local util = require("dap.dap-utils")

require("persistent-breakpoints").setup({
	load_breakpoints_event = { "BufReadPre" },
})

local persistent_breakpoints_api = require("persistent-breakpoints.api")

-- Set breakpoints, get variable values, step into/out of functions, etc.
map("n", "<leader>k", function()
	local expr = util.eval_expr
	if expr ~= nil and expr == "" then
		expr = nil
	end
	require("dapui").eval(expr, { context = "hover", enter = true })
end, opt)

-- 设置参数
vim.keymap.set("n", "<leader>-", util.set_args(), opt)
-- 设置eval的条件
vim.keymap.set("n", "<leader>=", function()
	util.set_eval_expr()
end, opt)

vim.keymap.set("n", "<F1>", function()
	dapui.toggle({})
end, opt)

vim.keymap.set("n", "<F2>", persistent_breakpoints_api.clear_all_breakpoints, opt)

vim.keymap.set("n", "<F3>", function()
	dapui.close({})
	dap.terminate()
end, opt)

vim.keymap.set("n", "<F4>", dap.run_to_cursor)
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F6>", dap.step_over)
vim.keymap.set("n", "<F7>", dap.step_into)
vim.keymap.set("n", "<F8>", dap.step_out)

-- Start debugging session
vim.keymap.set("n", "<F9>", function()
	dap_runner.run()
end)

-- runlast 这里的args仍然是之前的 即使你更改了
vim.keymap.set("n", "<F10>", function()
	dap.run_last()
end)

vim.keymap.set("n", "<F11>", persistent_breakpoints_api.toggle_breakpoint)
-- 设置条件断点
vim.keymap.set("n", "<F12>", persistent_breakpoints_api.set_conditional_breakpoint)

-- 重新进行
