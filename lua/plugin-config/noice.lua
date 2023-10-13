require("noice").setup({
	messages = {
		--view = "mini",
		view_error = "mini", -- view for errors
		view_warn = "mini", -- view for warnings
	},
	lsp = {
		progress = {
			enabled = true,
		},
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		signature = {
			enabled = true,
			auto_open = {
				enabled = false,
				trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
				luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
				throttle = 50, -- Debounce lsp signature help request by 50ms
			},
		},
		documentation = {
			view = "hover",
			opts = {
				lang = "markdown",
				replace = true,
				render = "plain",
				format = { "{message}" },
				win_options = { concealcursor = "n", conceallevel = 3 },
			},
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = true, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
	cmdline = {
		view = "cmdline",
		enabled= true
	},
	routes = {
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "written",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "ago",
			},
			opts = { skip = true },
		},
		--Already at newest change
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "change",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "fewer",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "more",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "--No lines",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "notify",
				kind = "",
				find = "Flutter",
			},
			opts = { skip = true },
		},
		-- Neo-tree
		{
			filter = {
				event = "notify",
				kind = "info",
				find = "[Neo-tree]",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "lsp",
				kind = "progress",
				any = {
					cond = function(message)
						print(message)
						local client = vim.tbl_get(message.opts, "progess", "client")
						return client == "null-ls" or client == "dartls"
					end,
				},
			},
			opts = { skip = true },
		},
	},
})
local keymap = vim.keymap
local opt = { silent = true, noremap = true }
keymap.set("n", "<leader>n", ":Noice dismiss<CR>")
