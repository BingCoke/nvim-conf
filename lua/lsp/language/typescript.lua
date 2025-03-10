-- local typescript_setup, typescript = pcall(require, "typescript")
local M = {}
local util = require("lspconfig.util")

function setupVtsls(lspconfig, capabilities, on_attach)
	lspconfig.volar.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "vue", "json" },
		--filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
		init_options = {
			vue = {
				hybridMode = false,
			},
		},
	})

	local mason_registry = require("mason-registry")
	local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
		.. "/node_modules/@vue/language-server"

	lspconfig.vtsls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		root_dir = util.root_pattern(".git", "turbo.json", "pnpm-workspace.yaml"),
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
		settings = {
			vtsls = {
				tsserver = {
					globalPlugins = {
						{
							name = "@vue/typescript-plugin",
							enableForWorkspaceTypeScriptVersions = true,
							location = vue_language_server_path,
							languages = { "vue" },
						},
						{
							name = "typescript-lit-html-plugin",
							tags = {
								"html",
								"template",
							},
							languages = { "html" },
						},
						{
							name = "typescript-plugin-css-modules",
							location = "/Users/bingcoke/.bun/install/global/node_modules/typescript-plugin-css-modules",
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
end
function setTypeTools(lspconfig, capabilities, on_attach)
	local capabilities = require("util.cmpUtil").getCapabilites()

	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.completionProvider = {
		resolveProvider = true,
		triggerCharacters = {
			".",
			'"',
			"'",
			"`",
			"/",
			"<",
			"$",
			"@",
			"{",
		},
	}

	require("typescript-tools").setup({
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue", -- This needed to be added.
		},
		inlay_hints = { enabled = true },
		on_attach = function(cli, buf)
			local conform = require("conform")
			local opts = { noremap = true, silent = true, buffer = buf }

			vim.keymap.set({ "n", "v" }, "<leader>l", function()
				conform.format({
					formatters = { { "esLint", "biomeLint" } },
					lsp_fallback = false,
					quiet = true,
					timeout_ms = 500,
					async = true,
				})
			end, opts)

			on_attach(cli, buf)
		end,
		root_dir = function(fname)
			-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/tsserver.lua#L22
			local root_dir = util.root_pattern(".git")(fname)
			return root_dir
		end,
		capabilities = capabilities,
		settings = {
			separate_diagnostic_server = true,
			publish_diagnostic_on = "change",
			expose_as_code_action = {},
			preferences = {
				includeCompletionsForModuleExports = true,
			},
			tsserver_plugins = {
				"typescript-plugin-css-modules",
				"@vue/typescript-plugin",
			},
			tsserver_file_preferences = {
				includeInlayParameterNameHints = "all",
				includeCompletionsForModuleExports = false,
				quotePreference = "single",
			},
		},
	})
end
function M.setup(lsp, default_capabilities, on_attach)
	setTypeTools(lsp, default_capabilities, on_attach)
end
return M
