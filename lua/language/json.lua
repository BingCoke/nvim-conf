local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end
local lspconf = require("lsp.lsp")

lspconfig["jsonls"].setup({
	capabilities = lspconf.capabilities,
	on_attach = lspconf.on_attach,
	settings = {
		json = {
			schemas = {
				{
					fileMatch = { "package.json" },
					url = "https://json.schemastore.org/package.json",
				},
				{
					fileMatch = { "tsconfig.json", "tsconfig.*.json" },
					url = "http://json.schemastore.org/tsconfig",
				},
				{
					fileMatch = { "biome.json" },
					url = "https://biomejs.dev/schemas/1.4.1/schema.json",
				},
			},
		},
	},
})
