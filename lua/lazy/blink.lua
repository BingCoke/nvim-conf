local init = false
return {
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
		},

		-- use a release tag to download pre-built binaries
		version = "*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts_extend = { "sources.default" },
		config = function()
			require("util.cmpUtil").blinkCmp = true
			require("blink.cmp").setup({
				snippets = { preset = "luasnip" },

				--signature = { enabled = true },

				sources = {
					default = { "lsp", "path", "snippets" },
					providers = {
						lsp = {
							transform_items = function(_, items)
								-- the default transformer will do this
								for _, item in ipairs(items) do
									if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
										item.score_offset = item.score_offset - 3
									end
								end

								-- you can define your own filter for rime item
								return items
							end,
						},
					},
				},
				completion = {
					documentation = {
						auto_show = false,
						auto_show_delay_ms = 50,
						window = {
							border = "rounded",
						},
					},
					keyword = { range = "full" },

					accept = { auto_brackets = { enabled = false } },
					menu = {
						border = "rounded",
						draw = {
							columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
							components = {
								kind_icon = {
									ellipsis = false,
									--width = { max = 1, fill = true },
									text = function(ctx)
										-- for tailwindcss color
										if ctx.kind == "Color" and ctx.item.client_name == "tailwindcss" then
											return "󱓻"
										end
										return ctx.kind_icon .. ctx.icon_gap
									end,
									highlight = function(ctx)
										return ctx.kind_hl
									end,
								},
							},
						},
						--components = {},
					},

					--ghost_text = { enabled = true },
				},
				cmdline = {
					enabled = true,
					completion = { menu = { auto_show = true } },
					keymap = {
						preset = "none",
						--
						["<M-space>"] = { "show", "show_documentation", "hide_documentation" },
						["<C-e>"] = { "hide" },
						["<tab>"] = { "select_and_accept", "fallback_to_mappings" },

						["<c-k>"] = { "select_prev", "fallback" },
						["<c-j>"] = { "select_next", "fallback" },
						["<C-p>"] = { "select_prev", "fallback_to_mappings" },
						["<C-n>"] = { "select_next", "fallback_to_mappings" },

						["<C-b>"] = { "scroll_documentation_up", "fallback" },
						["<C-f>"] = { "scroll_documentation_down", "fallback" },

						["<c-l>"] = { "snippet_forward", "fallback" },
						["<c-h>"] = { "snippet_backward", "fallback" },

						--["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
					},
					sources = function()
						local type = vim.fn.getcmdtype()
						-- Search forward and backward
						if type == "/" or type == "?" then
							return { "buffer" }
						end
						-- Commands
						if type == ":" or type == "@" then
							return { "cmdline" }
						end
						return {}
					end,
				},

				keymap = {
					preset = "none",
					["<M-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-e>"] = { "hide" },
					["<tab>"] = { "select_and_accept", "fallback" },
					["<c-k>"] = { "select_prev", "fallback" },
					["<c-j>"] = { "select_next", "fallback" },
					["<C-p>"] = { "select_prev", "fallback_to_mappings" },
					["<C-n>"] = { "select_next", "fallback_to_mappings" },
					["<C-u>"] = { "scroll_documentation_up", "fallback_to_mappings" },
					["<C-d>"] = { "scroll_documentation_down", "fallback_to_mappings" },
					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },
					["<c-l>"] = { "snippet_forward", "fallback" },
					["<c-h>"] = { "snippet_backward", "fallback" },

					--["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
				},
			})

			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-snippets", "./friendly-snippets" } })

			require("luasnip.loaders.from_vscode").lazy_load()

			require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets" })
		end,
	},
}
