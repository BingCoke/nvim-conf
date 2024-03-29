local DEBUGGER_PATH = vim.fn.stdpath("data") .. "/site/pack/packer/opt/vscode-js-debug"

local M = {}

function M.setup()
	local dap = require("dap")
	require("dap-vscode-js").setup({
		node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
		-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
		-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
		-- debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
		debugger_path = "/home/bk/tools/vscode-js-debug",
		adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
		-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
		-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
		-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
	})

	for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
		require("dap").configurations[language] = {
			{
				name = "React native",
				type = "pwa-node",
				request = "attach",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
				port = 35000,
			},
			{
				type = "pwa-chrome",
				name = "Attach - Remote chrome Debugging",
				request = "attach",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				port = 9222,
				webRoot = "${workspaceFolder}",
			},
			{
				type = "pwa-chrome",
				name = "Launch Chrome",
				request = "launch",
				url = "http://localhost:34115",
				port = 9222,
				protocol = "inspector",
				sourceMaps = true,
			},
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch node",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},

			{
				type = "pwa-node",
				request = "attach",
				name = "Node Attach",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Next.js: debug full stack",
				type = "node-terminal",
				request = "launch",
				command = "pnpm run dev",
				serverReadyAction = {
					pattern = "- Local:.+(https?://.+)",
					uriFormat = "%s",
					action = "debugWithChrome",
				},
			},
			{
				name = "Next.js: debug server-side",
				type = "node-terminal",
				request = "launch",
				command = "npm run dev",
			},
			{
				name = "Next.js: debug client-side",
				type = "pwa-chrome",
				request = "launch",
				url = "http://localhost:3000",
			},
		}
	end
end

M.run = function()
	require("dap").continue()
end
return M
