local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "biomejs" },
	javascriptreact = { "biomejs" },
	typescript = { "biomejs" },
	typescriptreact = { "biomejs" },
	json = { "biomejs" },
}

vim.keymap.set({ "n", "v" }, "<leader>l", function() end)
