local M = {}

local lsp = require("lsp.lsp")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities
local default_capabilities = lsp.default_capabilities

M.setup = function()
	vim.lsp.enable("intelephense")
	vim.lsp.config("intelephense", {
		capabilities = capabilities,
		on_attach = on_attach,
		init_options = {
			licenceKey = "/Users/bingcoke/.config/intelephense/licence",
		},
		settings = {},
	})
end
return M
