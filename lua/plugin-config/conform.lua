local conform = require("conform")
local util = require("conform.util")

local biomeLint = {
	command = util.from_node_modules("biome"),
	stdin = false,
	cwd = require("conform.util").root_file({ "biome.json" }),
	require_cwd = true,
	args = { "lint", "--apply", "$FILENAME" },
}

local esLint = {
	command = util.from_node_modules("eslint"),
	stdin = false,
	args = { "--fix", "$FILENAME" },
}

conform.setup({
	formatters = {
		esLint = esLint,
		biomeLint = biomeLint,
		biome = {
			cwd = require("conform.util").root_file({ "biome.json" }),
			require_cwd = true,
		},
	},
	formatters_by_ft = {
		javascript = { { "biome", "prettierd" } },
		javascriptreact = { "biome", "prettierd" },
		typescript = { { "biome", "prettierd" } },
		typescriptreact = { "biome", "prettierd" },
		xml = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { { "biome", "prettierd" } },
		lua = { "stylua" },
		yaml = { "yamlfmt" },
		shell = { "shfmt" },
		php = { "php_cs_fixer" },
		-- Use the "*" filetype to run formatters on all filetypes.
		["*"] = { "codespell" },
		-- Use the "_" filetype to run formatters on filetypes that don't
		-- have other formatters configured.
		["_"] = { "trim_whitespace" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	conform.format({
		lsp_fallback = true,
		timeout_ms = 1000,
		async = true,
	})
end)
