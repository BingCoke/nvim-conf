local lsp_conf = require("lsp.lsp")

require("lspconfig").gopls.setup({
	capabilities = lsp_conf.default_capabilities,
	on_attach = function(client, bufnr)
		lsp_conf.on_attach(client, bufnr)
	end,
	settings = {
		gopls = {
			buildFlags = {
				"-tags=wireinject",
				--"-tags=!wireinject",
			},

			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			codelenses = {
				generate = true, --// Don't show the `go generate` lens.
				gc_details = true, --// Show a code lens toggling the display of gc's choices.
			},
		},
	},
})
