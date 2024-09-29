local M = {}
local keymap = vim.keymap -- for conciseness
local util = require("lspconfig.util")

function M.setup(lspconfig, capabilities, on_attach)
	-- configure pyright server
	-- py-lsp
	-- python-lsp
	local root_files = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
		--"__init__.py",
	}

	local py_cap = vim.lsp.protocol.make_client_capabilities()
	py_cap.textDocument.completion.completionItem.snippetSupport = true
	--[[ lspconfig['pylsp'].setup({
  capabilities = py_cap,
  on_attach = on_attach,
  root_dir = util.root_pattern(unpack(root_files)),
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 100
        },
        rope_autoimport = {
          enabled = true
        }
      }
    }

  }
  }) ]]
	lspconfig["basedpyright"].setup({
		capabilities = py_cap,
		on_attach = on_attach,
		root_dir = util.root_pattern(unpack(root_files)),
		settings = {
			basedpyright = {
				typeCheckingMode = "basic",
				--ignore = { "*" },
			},
			python = {
				analysis = {
					--autoImportCompletions = true,
					--ignore = { "*" },
					typeCheckingMode = "basic",
					--diagnosticMode = "workspace",
					--stubPath = "/usr/lib/python3.11",
				},
			},
		},
	})

	--lspconfig["ruff_lsp"].setup({
	--	capabilities = py_cap,
	--	on_attach = function(cli, buf)
	--		cli.server_capabilities.hoverProvider = false
	--		on_attach(cli, buf)
	--	end,
	--	root_dir = util.root_pattern(unpack(root_files)),
	--	settings = {},
	--})

	--[[ lspconfig.pylsp.setup({
    capabilities = py_cap,
    on_attach = on_attach,
  }) ]]
end

return M
