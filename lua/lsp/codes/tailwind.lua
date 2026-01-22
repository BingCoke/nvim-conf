local M = {}

local lsp = require("lsp.lsp")
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities
local default_capabilities = lsp.default_capabilities

M.setup = function()
	vim.lsp.config("tailwindcss", {
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
			tailwindCSS = {

				classFunctions = {
					"useResolveClassNames",
				},
				classAttributes = {
					"class",
					"classList",
					"className",
					".*Style",
					".*Class",
					".*ClassName",
					"headerClassName",
					"contentContainerClassName",
					"columnWrapperClassName",
					"endFillColorClassName",
					"imageClassName",
					"tintColorClassName",
					"ios_backgroundColorClassName",
					"thumbColorClassName",
					"trackColorOnClassName",
					"trackColorOffClassName",
					"selectionColorClassName",
					"cursorColorClassName",
					"underlineColorAndroidClassName",
					"placeholderTextColorClassName",
					"selectionHandleColorClassName",
					"colorsClassName",
					"progressBackgroundColorClassName",
					"titleColorClassName",
					"underlayColorClassName",
					"colorClassName",
					"drawerBackgroundColorClassName",
					"statusBarBackgroundColorClassName",
					"backdropColorClassName",
					"backgroundColorClassName",
					"ListFooterComponentClassName",
					"ListHeaderComponentClassName",
				},
			},

			experimental = {
				classRegex = {
					{ "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "(?:twMerge|twJoin)\\(([^\\);]*)[\\);]", "[`'\"`]([^'\"`,;]*)[`'\"`]" },
					{ "classNames\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
					{ "windVars\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
				},
			},
		},
	})
	vim.lsp.enable("tailwindcss")
end
return M
