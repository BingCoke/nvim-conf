local M = {}

local util = require("lspconfig/util")
local lsp = require("lsp.lsp")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities
local default_capabilities = lsp.default_capabilities

M.setup = function()
	local root_files = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
		--"__init__.py",
	}

	vim.lsp.enable("basedpyright")
	vim.lsp.config("basedpyright", {
		capabilities = capabilities,
		on_attach = on_attach,
		root_dir = util.root_pattern(unpack(root_files)),
		settings = {
			basedpyright = {
				analysis = {
					typeCheckingMode = "basic",
					diagnosticSeverityOverrides = {
						reportUnusedImport = false,
					},
				},
				--ignore = { "*" },
			},
		},
	})
end
return M
