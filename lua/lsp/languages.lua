local lsps = {
	"lua",
	"ts",
	"eslint",
	"python",
	"go",
	"html",
	"tailwind",
	"rust",
	"php",
	"json",
	"markdown",
}

for _, value in ipairs(lsps) do
	local states, mod = pcall(require, "lsp.codes." .. value)

	if not states then
		print("No LSP support for " .. value)
		return
	end
	print("set up ", value)

	mod.setup()
end

local simpleLsps = {
	"bashls",
	"lemminx",
	"prismals",
	"arduino_language_server",
	"lemminx",
	"thriftls",
	"css_variables",
	"tsp_server",
	"buf_ls",
	"awk_ls",
	"yamlls",
}

local lsp = require("lsp.lsp")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities
local default_capabilities = lsp.default_capabilities
for _, value in ipairs(simpleLsps) do
	vim.lsp.enable(value)
	vim.lsp.config(value, {
		capabilities = capabilities,
		on_attach = on_attach,
	})
end
