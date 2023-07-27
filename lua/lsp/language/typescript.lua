-- local typescript_setup, typescript = pcall(require, "typescript")
local M = {}

function M.setup(lsp, default_capabilities, on_attach)
	require("typescript-tools").setup({
		on_attach = function(cli, buf)
			on_attach(cli, buf)
		end,
		capabilities = default_capabilities,
		--handlers = { ... },
		settings = {
			-- spawn additional tsserver instance to calculate diagnostics on it
			separate_diagnostic_server = true,
			-- "change"|"insert_leave" determine when the client asks the server about diagnostic
			publish_diagnostic_on = "insert_leave",
			-- array of strings("fix_all"|"add_missing_imports"|"remove_unused")
			-- specify commands exposed as code_actions
			expose_as_code_action = {},
		},
	})
end

return M
