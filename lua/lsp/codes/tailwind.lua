local M = {}

local lsp = require("lsp.lsp")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities
local default_capabilities = lsp.default_capabilities

M.setup = function()
	require("tailwind-tools").setup({
		server = {
			override = true,
			settings = {
				filetypes = {
					"templ",
					"vue",
					"html",
					"astro",
					"javascript",
					"typescript",
					"react",
					"htmlangular",
				},
				experimental = {
					-- https://github.com/paolotiu/tailwind-intellisense-regex-list#tailwind-merge
					classRegex = {
						{ "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
						{ "(?:twMerge|twJoin)\\(([^\\);]*)[\\);]", "[`'\"`]([^'\"`,;]*)[`'\"`]" },
						{ "classNames\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
						{ "windVars\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
						{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					},
				},
				classAttributes = { "class", "classList", "className", ".*Style", ".*Class", ".*ClassName" },
			},
		},
	})
end
return M
