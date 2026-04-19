local M = {}

local lsp = require("lsp.lsp")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities

M.setup = function()
	vim.lsp.enable("gopls")
	vim.lsp.config("gopls", {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			lsp.on_attach(client, bufnr)
		end,
		settings = {
			gopls = {},
		},
	})
end

return M
