-- local typescript_setup, typescript = pcall(require, "typescript")
local M = {}

function M.setup(lsp, default_capabilities, on_attach)
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.completionProvider = {
		resolveProvider = true,
		triggerCharacters = {
			".",
			'"',
			"'",
			"`",
			"/",
			"<",
		},
	}

	local make_capabilities = require("typescript-tools.capabilities")
	require("typescript-tools").setup({
		on_attach = function(cli, buf)
			on_attach(cli, buf)
		end,
		--handlers = { ... },
		capabilities = capabilities,
		settings = {
			-- spawn additional tsserver instance to calculate diagnostics on it
			separate_diagnostic_server = true,
			-- "change"|"insert_leave" determine when the client asks the server about diagnostic
			publish_diagnostic_on = "insert_leave",
			-- array of strings("fix_all"|"add_missing_imports"|"remove_unused")
			-- specify commands exposed as code_actions
			expose_as_code_action = {},
			tsserver_plugins = {
				-- for TypeScript v4.9+
				--"@styled/typescript-styled-plugin",
				-- or for older TypeScript versions
				--"typescript-styled-plugin",
				"typescript-plugin-css-modules",
			},
			tsserver_file_preferences = {
				includeInlayParameterNameHints = "all",
				includeCompletionsForModuleExports = true,
				quotePreference = "single",
			},
		},
	})
end

return M
