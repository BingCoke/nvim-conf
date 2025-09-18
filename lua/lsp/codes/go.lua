local M = {}

local lsp = require("lsp.lsp")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities
local default_capabilities = lsp.default_capabilities

M.setup = function()
	local lsp_conf = require("lsp.lsp")
  vim.lsp.enable("gopls")
	vim.lsp.config("gopls", {
		capabilities = lsp_conf.default_capabilities,
		on_attach = function(client, bufnr)
			lsp_conf.on_attach(client, bufnr)
		end,
		settings = {
			gopls = {
				buildFlags = {
					"-tags=wireinject",
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
end

return M
