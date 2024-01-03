local conform = require("conform")
local util = require("conform.util")

local biome = {
	command = util.from_node_modules("biome"),
	stdin = false,
	args = { "lint", "--apply", "$FILENAME" },
}

local esLint = {
	command = util.from_node_modules("eslint"),
	stdin = false,
	args = { "--fix", "$FILENAME" },
}

conform.setup({
	formatters = {
		tsLint = esLint,
	},
	formatters_by_ft = {
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		lua = { "stylua" },
		yaml = { "yamlfmt" },
		shell = { "shfmt" },
		php = { "php_cs_fixer" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	conform.format({
		lsp_fallback = true,
		timeout_ms = 1000,
		async = true,
	})
end)
