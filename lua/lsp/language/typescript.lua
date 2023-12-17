-- local typescript_setup, typescript = pcall(require, "typescript")
local M = {}
local util = require("lspconfig.util")

function M.setup(lsp, default_capabilities, on_attach)
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
		},
	}

	require("typescript-tools").setup({
		on_attach = function(cli, buf)
			local conform = require("conform")
			local opts = { noremap = true, silent = true, buffer = buf }

			vim.keymap.set({ "n", "v" }, "<leader>l", function()
				conform.format({
					formatters = { "biomeLint" },
					lsp_fallback = true,
					timeout_ms = 500,
				})
			end)
			on_attach(cli, buf)
		end,
		root_dir = function(fname)
			-- INFO: stealed from:
			-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/tsserver.lua#L22
			local root_dir = util.root_pattern(".git")(fname)
			return root_dir
		end,

		--handlers = { ... },
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
			},
			tsserver_file_preferences = {
				includeInlayParameterNameHints = "all",
				includeCompletionsForModuleExports = false,
				quotePreference = "single",
			},
		},
	})
end

return M
