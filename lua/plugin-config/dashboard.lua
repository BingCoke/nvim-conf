require("dashboard").setup({
	theme = "doom",
	config = {
		center = {
			{
				icon = "  ",
				desc = "Projects                            ",
				key = "p",
				action = function()
					require("telescope").extensions.myprojects.myprojects({})
				end,
			},
			{
				icon = "  ",
				key = "<c-p>",
				desc = "current                            ",
				action = function()
					vim.cmd([[NvimTreeClose]])
					require("telescope").extensions.my_file_find.find_files({})
				end,
			},
			{
				icon = "  ",
				key = "r",
				desc = "Recently files                      ",
				action = "Telescope oldfiles",
			},
			{
				icon = "  ",
				key = "s",
				desc = "Edit Snippets                    ",
				action = "edit ~/.config/nvim/my-snippets",
			},
			{
				icon = "  ",
				key = "e",
				desc = "Edit Projects                       ",
				action = "edit ~/.local/share/nvim/project_nvim/project_history",
			},
			{
				icon = "  ",
				key = "z",
				desc = "Edit .fish                        ",
				action = "edit ~/.config/fish/config.fish",
			},
		},
		footer = {
			"",
			"",
			"hello world !",
		},

		header = {
			[[ _          _ _         ____  _              ____      _         ]],
			[[| |__   ___| | | ___   | __ )(_)_ __   __ _ / ___|___ | | _____  ]],
			[[| '_ \ / _ \ | |/ _ \  |  _ \| | '_ \ / _` | |   / _ \| |/ / _ \ ]],
			[[| | | |  __/ | | (_) | | |_) | | | | | (_| | |__| (_) |   <  __/ ]],
			[[|_| |_|\___|_|_|\___/  |____/|_|_| |_|\__, |\____\___/|_|\_\___| ]],
			[[                                      |___/                      ]],
		},
	},
})
