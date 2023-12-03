-- import mason plugin safely
local mason = require("mason")

-- import mason-lspconfig plugin safely
local mason_lspconfig = require("mason-lspconfig")

-- import mason-null-ls plugin safely

-- enable mason
mason.setup({})

-- http://www.baidu.com
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
		"shfmt",
		"gopls",
		"dockerls",
		"docker_compose_language_service",
		"marksman",
		"pyright",
	},
})
