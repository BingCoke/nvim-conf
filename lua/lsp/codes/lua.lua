local M = {}

local lsp = require("lsp.lsp")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities
local default_capabilities = lsp.default_capabilities

M.setup = function()
	vim.lsp.config("lua_ls", {
		on_attach = on_attach,
		capabilities = capabilities,
	})
	vim.lsp.enable("lua_ls")
end

return M
