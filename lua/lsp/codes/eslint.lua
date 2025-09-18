local M = {}

local lsp = require("lsp.lsp")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities
local default_capabilities = lsp.default_capabilities
local util = require("lspconfig/util")

M.setup = function()
	vim.lsp.enable("eslint", true)
	vim.lsp.config("eslint", {
		capabilities = capabilities,
		on_attach = on_attach,
		root_dir = function(filename, bufnr)
			if string.find(filename, "node_modules/") then
				return nil
			end
			return util.root_pattern(
				"eslint.config.js",
				"eslint.config.mjs",
				"eslint.config.cjs",
				"eslint.config.ts",
				"eslint.config.mts",
				"eslint.config.cts"
			)()
		end,
	})
end
return M
