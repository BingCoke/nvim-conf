local M = {}

local util = require("lspconfig.util")
local svecapabilities = require("util.cmp").getCapabilites()
local lsp = require("lsp.lsp")
local on_attach = lsp.on_attach

M.setup = function()
	local vue_language_server_path = vim.fn.expand("$MASON/packages")
		.. "/vue-language-server"
		.. "/node_modules/@vue/language-server"

	local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
	local vue_plugin = {
		name = "@vue/typescript-plugin",
		location = vue_language_server_path,
		languages = { "vue" },
		configNamespace = "typescript",
	}

	vim.lsp.config("vtsls", {
		capabilities = svecapabilities,
		on_attach = on_attach,
		filetypes = tsserver_filetypes,
		settings = {
			vtsls = {
				tsserver = {
					globalPlugins = {
						vue_plugin,
						{
							name = "typescript-svelte-plugin",
							location = vim.fn.stdpath("data") .. "/mason/packages/svelte-language-server",
							languages = { "svelte" },
							configNamespace = "typescript",
							enableForWorkspaceTypeScriptVersions = true,
						},
					},
					preferences = {
						includeInlayFunctionLikeReturnTypeHints = false,
					},
				},
			},
			typescript = {
				inlayHints = {
					parameterNames = { enabled = "all" },
					propertyDeclarationTypes = { enabled = true },
					functionLikeReturnTypes = { enabled = true },
					enumMemberValues = { enabled = true },
					parameterTypes = { enabled = true },
					variableTypes = { enabled = true },
				},
			},
		},
	})

	vim.lsp.config("svelte", {
		capabilities = svecapabilities,
		on_attach = function(client, b)
			-- tell the lsp server to reload the ts/js file when it's saved
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = { "*.js", "*.ts" },
				callback = function(ctx)
					client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
				end,
			})

			on_attach(client, b)
		end,
		settings = {},
	})

	vim.lsp.config("tsgo", {
		capabilities = svecapabilities,
		on_attach = on_attach,
	})

	vim.lsp.enable("vue_ls")
	vim.lsp.enable("svelte")
	--vim.lsp.enable("tsgo")
	vim.lsp.enable("vtsls")
end

return M
