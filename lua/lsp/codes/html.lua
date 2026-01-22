local M = {}

local lsp = require("lsp.lsp")
local util = require("lspconfig/util")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities
local default_capabilities = lsp.default_capabilities

M.setup = function()
	vim.lsp.enable("html")
	vim.lsp.config("html", {
		capabilities = default_capabilities,
		--root_dir = util.root_pattern(".git", "turbo.json", "pnpm-workspace.yaml"),
		on_attach = on_attach,
		init_options = {
			provideFormatter = false,
			configurationSection = { "html", "css", "javascript" },
			embeddedLanguages = {
				css = true,
				javascript = true,
			},
		},
	})
end
return M
