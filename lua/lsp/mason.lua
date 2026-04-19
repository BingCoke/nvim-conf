local mason = require("mason")
-- import mason-lspconfig plugin safely
local mason_lspconfig = require("mason-lspconfig")
-- enable mason
mason.setup({})

mason_lspconfig.setup({
	automatic_enable = false,
	-- list of servers for mason to install
	ensure_installed = {
		"ts_ls",
		"html",
		"lua_ls",
		"cssls",
		"tailwindcss",
		"emmet_ls",
		"gopls",
		"dockerls",
		"docker_compose_language_service",
		"marksman",
		"pyright",
		"rust_analyzer",
		"biome",
		"cssls",
		"gopls",
		"html",
		"marksman",
		"eslint",
		"astro",
	},
})

