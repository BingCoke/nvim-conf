require("util.cmpUtil").blinkCmp = true

return {
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
		},
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts_extend = { "sources.default" },
		config = function()
			require("blink.cmp").setup({
				snippets = { preset = "luasnip" },
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
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
					accept = { auto_brackets = { enabled = false } },
					menu = {
						border = "rounded",
						draw = {
							columns = {
								{ "kind_icon" },
								{ "label", "label_description", gap = 1 },
								{ "kind" },
							},
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

				},
				cmdline = {
					enabled = true,
					completion = { menu = { auto_show = true } },
					keymap = {
						preset = "none",
						["<M-space>"] = { "show", "show_documentation", "hide_documentation" },
						["<C-e>"] = { "hide" },
						["<tab>"] = { "select_and_accept", "fallback_to_mappings" },
						["<c-k>"] = { "select_prev", "fallback" },
						["<c-j>"] = { "select_next", "fallback" },
						["<C-p>"] = { "select_prev", "fallback_to_mappings" },
						["<C-n>"] = { "select_next", "fallback_to_mappings" },
						["<C-u>"] = { "scroll_documentation_up", "fallback" },
						["<C-d>"] = { "scroll_documentation_down", "fallback" },

						["<c-l>"] = { "snippet_forward", "fallback" },
						["<c-h>"] = { "snippet_backward", "fallback" },
					},
					sources = function()
						local type = vim.fn.getcmdtype()
						if type == "/" or type == "?" then
							return { "buffer" }
						end
						-- Commands
						if type == ":" or type == "@" then
							-- 如果真的是需要进行命令行模式 那么你需要如下的配置
							return { "cmdline" }
						end
						return {}
					end,
				},

				keymap = {
					preset = "none",
					["<M-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-f>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-e>"] = { "hide" },
					["<tab>"] = { "select_and_accept", "fallback" },
					["<c-k>"] = { "select_prev", "fallback" },
					["<c-j>"] = { "select_next", "fallback" },
					["<C-p>"] = { "select_prev", "fallback_to_mappings" },
					["<C-n>"] = { "select_next", "fallback_to_mappings" },
					["<C-u>"] = { "scroll_documentation_up", "fallback_to_mappings" },
					["<C-d>"] = { "scroll_documentation_down", "fallback_to_mappings" },
					--["<c-l>"] = { "snippet_forward", "fallback" },
					--["<c-h>"] = { "snippet_backward", "fallback" },
					["<right>"] = { "snippet_forward", "fallback" },
					["<left>"] = { "snippet_backward", "fallback" },
					--["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
				},
			})

			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-snippets", "./friendly-snippets" } })

			require("luasnip.loaders.from_vscode").lazy_load()

			require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets" })
		end,
	},
}
