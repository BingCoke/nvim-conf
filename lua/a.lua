require("blink.cmp").setup({
	snippets = { preset = "luasnip" },
	sources = {
		default = { "lsp", "path", "snippets" },
		providers = {},
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 50,
			window = {
				border = "rounded",
			},
		},
		keyword = { range = "full" },
		trigger = {
			show_on_blocked_trigger_characters = { " ", "\n", "\t", "$", ":" },
		},
		accept = { auto_brackets = { enabled = false } },
		--ghost_text = { enabled = true },
	},
})
