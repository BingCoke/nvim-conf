-- import mason plugin safely
local mason = require("mason")
-- import mason-lspconfig plugin safely
local mason_lspconfig = require("mason-lspconfig")
-- enable mason
mason.setup({})

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"tsserver",
		"html",
		"lua_ls",
		"cssls",
		"tailwindcss",
		"emmet_ls",
		"clangd",
		"gopls",
		"dockerls",
		"docker_compose_language_service",
		"marksman",
		"pyright",
	},
})
