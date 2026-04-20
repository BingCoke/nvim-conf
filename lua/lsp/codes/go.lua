local M = {}

local lsp = require("lsp.lsp")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities

M.setup = function()
	vim.lsp.config("gopls", {
		on_attach = function(cli, buf)
			on_attach(cli,buf)
		end,
		capabilities = capabilities,
		settings = {
			gopls = {},
		},
	})
	vim.lsp.enable("gopls")
end

return M
