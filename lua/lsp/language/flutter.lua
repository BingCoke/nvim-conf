local M = {}
local keymap = vim.keymap -- for conciseness

function M.setup(lspconfig, capabilities, on_attach)

	require("flutter-tools").setup({
		dev_tools = {
			autostart = true, -- autostart devtools server if not detected
			auto_open_browser = true, -- Automatically opens devtools in the browser
		},
		widget_guides = {
			enabled = true,
		},
		lsp = {
			on_attach = on_attach,
			capabilities = capabilities,
			color = {
				enabled = true,
			},
			settings = {
				--enableSdkFormatter = false,
			},
		},
		-- {
		--[[ "name": "my_app",
            "request": "launch",
            "type": "dart"
        },
        {
            "name": "my_app (profile mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile"
        },
        {
            "name": "my_app (release mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release"
        } ]]
		debugger = {
			enabled = true,
			run_via_dap = true,
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
