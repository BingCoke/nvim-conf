return {

	-- dap
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"Weissle/persistent-breakpoints.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"mxsdev/nvim-dap-vscode-js",
			{
				"microsoft/vscode-js-debug",
				build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			},
		},
		config = function()
			require("dap.dap")
			require("dap.dap-virtual-text")
			require("dap.dap-ui")
			require("dap.dap-keymap")
		end,
		ft = {
			"rust",
			"go",
			"python",
			"shell",
			"dart",
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
			"dart",
			"kotlin",
		},
	},
	{
		"sultanahamer/nvim-dap-reactnative",
		ft = {
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
		},
	},
}
