local M = {}

local util = require("lspconfig/util")
local lsp = require("lsp.lsp")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities
local default_capabilities = lsp.default_capabilities

M.setup = function()
	vim.lsp.enable("jsonls")
	vim.lsp.config("jsonls", {
		capabilities = capabilities,
		on_attach = on_attach,
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
end
return M
