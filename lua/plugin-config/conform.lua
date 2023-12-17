local conform = require("conform")
local util = require("conform.util")

conform.setup({
	formatters = {
		biomeLint = {
			command = util.from_node_modules("biome"),
			stdin = false,
			args = { "lint", "--apply", "$FILENAME" },
		},
	},
	formatters_by_ft = {
		javascript = { "biome" },
		javascriptreact = { "biome" },
		typescript = { "biome" },
		typescriptreact = { "biome" },
		json = { "biome" },
		lua = { "stylua" },
		css = { "prettier" },
		html = { "prettier" },
		yaml = { "yamlfmt" },
		shell = { "shfmt" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	conform.format({
		lsp_fallback = true,
		timeout_ms = 500,
	})
end)
